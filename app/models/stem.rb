class Stem < ActiveRecord::Base
  
  has_many :results
  has_many :participants, :through => :results
  
  attr_accessor :display_order, :experiment_phase
  
  def to_s
    "Singular: #{ self.singular }
    Plural: #{ self.plural }
    Vowel: #{ self.vowel }
    Stress: #{ self.stress }\n"
  end
end
