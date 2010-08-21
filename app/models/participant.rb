class Participant < ActiveRecord::Base
  
  has_many :results
  has_many :learning_items, :source => :stem, :through => :results
  has_many :testing_items, :source => :stem, :through => :results
  
  def self.inheritance_column
    "experiment_type"
  end
  
  def generate_code
    code = id
  end
  
end
