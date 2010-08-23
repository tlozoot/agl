class Experiments::ResultsController < ApplicationController
 
  before_filter :get_participant
  
  def index
    
  end
  
  def new
    
  end
  
  def create
    
  end
  
  private
  
  def get_participant
    @participant = Participant.find(params[:experiment_id])
  end
  
end
