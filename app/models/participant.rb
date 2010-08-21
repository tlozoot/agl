class Participant < ActiveRecord::Base
  
  has_many :results
  has_many :training_items, :as => :stems, :through => :results
  has_many :testing_items, :as => :stems, :through => :results
  
  def self.inheritance_column
    "experiment_type"
  end
  
  def generate_code
    code = id
  end
  
end
