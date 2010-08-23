class Result < ActiveRecord::Base

  belongs_to :stem
  belongs_to :participant
  
  before_save :update_info
  
  validates_presence_of :stem, :participant
  
  def update_info
    display_order = stem.display_order
    experiment_phase = stem.experiment_phase
    reponse = stem.response
  end

end
