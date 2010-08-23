class Result < ActiveRecord::Base

  belongs_to :stem
  belongs_to :participant
  belongs_to :clipart
    
  validates_presence_of :stem, :participant
  
  def to_s
    stem.to_s.chomp + "
    Order: #{display_order}
    Phase: #{experiment_phase}
    Response: #{response}"
  end

end
