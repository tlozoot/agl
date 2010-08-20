class Participant < ActiveRecord::Base
  
  has_many :results
  has_many :stems, :through => :results
  
  def training_items
    @control_items = Stem.find(:all, :conditions => "vowel = 'a'").randomly_pick(5)
    @training_items = Stem.find(:all, :conditions => ["(vowel = 'e' OR vowel = 'u') AND stress = ?", self.training_group]).randomly_pick(5)
    (@control_items + @training_items).sort_by{ rand }.add_display_order.each{ |item| item.experiment_phase = 'training' }
  end
  
  def testing_items
    @control_items = Stem.find(:all, :conditions => "vowel = 'a'").randomly_pick(5)
    @test_items = Stem.find(:all, :conditions => "vowel = 'e' OR vowel = 'u'").randomly_pick(5)
    (@control_items + @test_items).sort_by{ rand }.add_display_order.each{ |item| item.experiment_phase = 'testing' }
  end
  
  def generate_code
    code = id
  end
  
end
