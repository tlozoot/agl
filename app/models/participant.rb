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
      @correct_plurals << r if (r.paradigm.spelled_plural == r.response) && r.experiment_phase == 'testing'
    end
    @correct_plurals
  end
  
  def generate_items
    assign_training_group
    @paradigms = Paradigm.assign_pictures_to_paradigms_of_type(experiment_type.downcase)
  
    @control_words = control_words
    
    @experimental_words = {}
    @experimental_words[:testing]  = testing_words 
    @experimental_words[:learning] = @experimental_words[:testing].deep_copy.select do |s|
      s.stress == self.training_group  
    end
    
    @items = {}
    @items = {
      :training => training_items,
      :learning => experiment_items(:learning),
      :testing  => experiment_items(:testing),
    }
    
    @items[:training_test] = @items[:training]
    
    [:training, :training_test, :learning, :testing].each do |phase|
      @items[phase].each do |item|
        self.results.create(:paradigm => item, :clipart => item.clipart, :experiment_phase => phase.to_s)
      end
    end
    
    self.results.each_index do |i|
      self.results[i].display_order = i + 1
      self.results[i].save
    end
  end
  
  private
  
  def experiment_items(phase)
    @items = (@control_words.deep_copy.randomly_pick(5) + @experimental_words[phase].randomly_pick(5)) \
             .sort_by{ rand }
  end
  

  
end
