class Result < ActiveRecord::Base

  belongs_to :stem
  belongs_to :participant
  belongs_to :clipart
    
  validates_presence_of :stem, :participant

end
