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
    unless next_result.nil?
      if @result.experiment_phase != next_result.experiment_phase
        redirect_to :action => next_result.experiment_phase
      else
        redirect_to experiment_response_url(@participant, next_result.display_order)
      end
    else
      render :finished
    end
  end
  
  def training ; end
  
  def learning 
    get_next_result(:learning)
  end
  
  def testing 
    get_next_result(:testing)
  end
  
  def finished ; end

  private
  
  def get_participant
    @participant = Participant.find(params[:experiment_id])
  end
  
  def get_next_result(phase)
    @next_result = @participant.select_results(phase) \
                               .sort{ |a,b| a.display_order <=> b.display_order } \
                               .first
  end
  
end
