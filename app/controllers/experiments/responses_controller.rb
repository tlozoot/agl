class Experiments::ResponsesController < ApplicationController
 
  before_filter :get_participant
  
  def index
  end
  
  def show
    @stem = Stem.find(params[:id])
    @result = Result.new(:stem => @stem)
  end
  
  def create
    @result = @participant.results.build(params[:result])
    if @result.save
      # redirect_to experiment_response_url(@participant, )
    else
      flash[:notice] = "Sorry, we couldn't save your results!"
      render :index 
    end
  end
  
  private
  
  def get_participant
    @participant = Participant.find(params[:experiment_id])
  end
  
end
