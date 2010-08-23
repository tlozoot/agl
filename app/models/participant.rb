class Participant < ActiveRecord::Base
  
  has_many :results
  has_many :stems, :through => :results
  accepts_nested_attributes_for :stems
  
  before_save :generate_code
  after_save :update_results_from_stems
  
  validates_presence_of :name
  
  def self.inheritance_column
    "experiment_type"
  end
  
  def generate_code
    self.code = Digest::MD5.hexdigest(name + Time.now.to_s)
  end
  
  def items
    self.results.map do |r| 
       stem = r.stem
       stem.experiment_phase = r.experiment_phase
       stem.display_order = r.display_order
       stem.response = r.response
       stem
     end
  end
  
  def select_items(phase)
    self.items.select{ |r| r.experiment_phase == phase.to_s }
  end
  
  def update_results_from_stems
    self.results.each do |r|
      stem = self.stems.select{ |s| s.id == r.stem_id }.first
      r.display_order = stem.display_order
      r.experiment_phase = stem.experiment_phase
      r.response = stem.response
      r.save
    end
  end
  
end
