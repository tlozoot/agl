class Participant < ActiveRecord::Base
  
  has_many :results
  has_many :stems, :through => :results
  accepts_nested_attributes_for :stems
  
  before_save :generate_code
  
  validates_presence_of :name
  
  def self.inheritance_column
    "experiment_type"
  end
  
  def generate_code
    self.code = Digest::MD5.hexdigest(name + Time.now.to_s)
  end
  
  def items(phase)
    stems.select{ |s| s.experiment_phase == phase.to_s }
  end
  
end
