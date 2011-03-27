class Participant < ActiveRecord::Base
  
  has_many :results
  accepts_nested_attributes_for :results
  
  validates_presence_of :experiment_type
  
  def self.inheritance_column
    "experiment_type"
  end
  
  def self.finished
    self.all.select{ |p| p.finished? }
  end
  
  def finished?
    self.experiment_position > self.results.length
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
  
  def pick_training_group
    return 'mono' # Remove this later!
  
    group1, group2 = self.groups    
    finished = self.experiment_type.capitalize.constantize.finished
    if finished.length > 0
      finished.select{ |p| p.training_group == group1 }.length < \
        finished.select{ |p| p.training_group == group2 }.length ? group1 : group2
    else
      rand > 0.5 ? group1 : group2
    end
  end
  
  # VARIABLE:
  # learning: 3 places * 3 of each (only one stress) + 1 extra [p] + 5 filler = 17 learning words
  # testing:  3 places * (3 training[1 old + 2 new] + 3 opposite training) + 1 of each extra for [p] + 3 old filler + 7 new filler = 34 testing words
  
  # FIXED:
  # learning: 2 places * 5 of each (only one stress) + 5 filler = 15 learning words
  # testing:  2 places * (5 training[2 old + 3 new] + 5 opposite training) + 3 old filler + 7 new filler = 30 testing words
  
  def generate_items
    assign_training_group
    @paradigms = Paradigm.assign_pictures_to_paradigms_of_type(experiment_type.downcase)
    
    @items = {}
    @items[:learning] = []
    @items[:testing] = []
    
    # Control words:
    # => Training: 2 same meter + 3 different meter = 5
    # => Testing: 5 same meter (1 old) + 5 different meter (2 old)
    @similar_control_words = paradigms_by_characteristic(control_places, training_group).randomly_pick(6)
    @different_control_words = paradigms_by_characteristic(control_places, opposite_training_group).randomly_pick(6)
    @items[:learning] += (@similar_control_words.first(2) + @different_control_words.first(3)).sort_by{ rand }
    @items[:testing] += (@similar_control_words.last(5) + @different_control_words.last(5)).sort_by{ rand }
    
    
    # Experimental words:
    # Variable => [t, k] get 3 each in learning, 1 old + 2 new in old place + 3 opposite place = 6 in testing
    #             [p] gets 4 in learning; 2 old + 2 new in old place + 4 opposite place = 8 in testing
    #             In other words, we want 5 total for [t,k] in old place and 6 total for [p]
    #
    # Fixed => Both places get 5 each in learning; 2 old + 3 new in testing + 5 opposite = 10 in testing
    #
    # In total, in experimental testing items, everyone sees 4 old items and 16 new ones
    
    places_of_articulation.each_pair do |place, number|
      @training_words = paradigms_by_characteristic(place, training_group).randomly_pick((number * 1.5).ceil)
      @items[:learning] += @training_words.last(number)
      @items[:testing] += @training_words.first(number)
      @items[:testing] += paradigms_by_characteristic(place, opposite_training_group).randomly_pick(number)
    end
        
    @bools = {}
    @bools[:learning] = Array.new(7, false) + Array.new(8, true) # spell the latter half of the learning words
    @bools[:testing] = Array.new(15, false) + Array.new(15, true) # hide the singulars in latter half of the testing
      
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
  
  def paradigms_by_characteristic(place, stress)
    @paradigms.select{ |p| p.method(independent_variable).call =~ Regexp.new(place) && p.stress == stress }
  end
      
end
