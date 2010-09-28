class Participant < ActiveRecord::Base
  
  has_many :results
  accepts_nested_attributes_for :results
  
  validates_presence_of :experiment_type
  
  def self.inheritance_column
    "experiment_type"
  end

  def self.generate_code
    code = (0..2).map{ (rand(26) + 65).chr }.join + Participant.all.length.to_s
  end

  def select_results(phase)
    self.results.select{ |r| r.experiment_phase == phase.to_s }
  end
  
  def assign_training_group
    self.training_group ||= pick_training_group
  end
  
  def correct_plurals
    @correct_plurals = []
    results.each do |r|
      @correct_plurals << r if (r.paradigm.human_plural == r.plural_response) && r.experiment_phase == 'testing'
    end
    @correct_plurals
  end
  
  def singular_play_count
    results.map(&:singular_play_count).inject { |sum, n| sum + n.to_i }
  end
  
  def plural_play_count
    results.map(&:plural_play_count).inject { |sum, n| sum + n.to_i }
  end
  
  # learning: 3 places * 3 of each (only one stress) + 9 filler = 18 learning words
  # testing:  3 places * (5 training[2 old + 3 new] + 5 opposite training) + 5 old filler + 5 new filler = 40 testing words
  
  # learning: 2 places * 5 of each (only one stress) + 5 filler = 15 learning words
  # testing:  2 places * (5 training[2 old + 3 new] + 5 opposite training) + 3 old filler + 7 new filler = 30 testing words
  def generate_items
    assign_training_group
    @paradigms = Paradigm.assign_pictures_to_paradigms_of_type(experiment_type.downcase)
    
    @items = {} # is this necessary?

    @items[:learning] = []
    @items[:testing] = []
    
    @control_words = control_words.randomly_pick(12) 
    @items[:learning] += @control_words.last(5)
    @items[:testing] += @control_words.first(10)
    
    places_of_articulation.each do |place|
      @training_words = training_words_by_place(place).randomly_pick(8)
      @items[:learning] += @training_words.last(5)
      @items[:testing] += @training_words.first(5)
      @items[:testing] += testing_words_by_place(place).randomly_pick(5)
    end
        
    @bools = {}
    @bools[:learning] = (1..7).map{ false } + (1..8).map{ true } # spell the latter half of the learning words
    @bools[:testing] = (1..15).map{ false } + (1..15).map{ true } # hide the singulars in latter half of the testing
      
    [:learning, :testing].each do |phase|
      @items[phase].sort_by{ rand }.each do |item|
        self.results.create(:paradigm => item, :clipart => item.clipart, :experiment_phase => phase.to_s, :both_responses => @bools[phase].shift)
      end
    end
        
    self.results.each_with_index do |result, i|
      result.display_order = i + 1
      result.save
    end
  end
  
  private
  
  def training_words_by_place(place)
    @paradigms.select{ |p| p.method(independent_variable).call == place && p.stress == training_group }
  end
  
  def testing_words_by_place(place)
    @paradigms.select{ |p| p.method(independent_variable).call == place && p.stress != training_group }
  end
  
end
