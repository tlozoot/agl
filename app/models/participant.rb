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
      @correct_plurals << r if (r.paradigm.plural == r.response) && r.experiment_phase == 'testing'
    end
    @correct_plurals
  end
  
  # learning: 3 places * 3 of each (only one stress) + 9 filler = 18 learning words
  # testing:  3 places * (5 training[2 old + 3 new] + 5 opposite training) + 5 old filler + 5 new filler = 40 testing words
  def generate_items
    assign_training_group
    @paradigms = Paradigm.assign_pictures_to_paradigms_of_type(experiment_type.downcase)
    
    @items = {} # is this necessary?
    @items[:training] = training_items
    @items[:training_test] = @items[:training]
    
    @items[:learning] = []
    @items[:testing] = []
    
    @control_words = control_words.randomly_pick(14) 
    @items[:learning] += @control_words.last(9)
    @items[:testing] += @control_words.first(10)
    
    places_of_articulation.each do |place|
      @training_words = training_words_by_place(place).randomly_pick(6)
      @items[:learning] += @training_words.last(3)
      @items[:testing] += @training_words.first(5)
      @items[:testing] += testing_words_by_place(place).randomly_pick(5)
    end
    
    [:training, :training_test, :learning, :testing].each do |phase|
      @items[phase].sort_by{ rand }
      @items[phase].each do |item|
        self.results.create(:paradigm => item, :clipart => item.clipart, :experiment_phase => phase.to_s)
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
