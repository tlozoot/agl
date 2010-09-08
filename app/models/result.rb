class Result < ActiveRecord::Base

  belongs_to :paradigm
  belongs_to :participant
  belongs_to :clipart
    
  validates_presence_of :paradigm, :participant
  
  def to_s
    paradigm.to_s.chomp + "
    Order: #{display_order}
    Phase: #{experiment_phase}
    Response: #{response}"
  end

end
