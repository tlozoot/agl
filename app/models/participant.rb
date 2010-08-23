class Participant < ActiveRecord::Base
  
  has_many :results
  accepts_nested_attributes_for :results
  
  before_save :generate_code
  
  validates_presence_of :name
  
  def self.inheritance_column
    "experiment_type"
  end
  
  def generate_code
    self.code = Digest::MD5.hexdigest(name + Time.now.to_s)
  end
  
  # def items
  #   self.results.map do |r| 
  #      stem = r.stem
  #      stem.experiment_phase = r.experiment_phase
  #      stem.display_order = r.display_order
  #      stem.response = r.response
  #      stem
  #    end
  # end
  
  def select_results(phase)
    self.results.select{ |r| r.experiment_phase == phase.to_s }
  end
  
end
