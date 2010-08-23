class Experiments::ResponsesController < ApplicationController
 
  before_filter :get_participant
  
  def index
  end
  
  def show
    @result = @participant.results.find_by_display_order(params[:id])
  end
  
  def update
    @result = @participant.results.find_by_display_order(params[:id])
    if @result.experiment_phase == 'testing'
      @result.update_attributes params[:result]
    end
    next_result = @participant.results.find_by_display_order(@result.display_order + 1)
    redirect_to experiment_response_url(@participant, next_result.display_order)
  end
  
  private
  
  def get_participant
    @participant = Participant.find(params[:experiment_id])
  end
  
end
