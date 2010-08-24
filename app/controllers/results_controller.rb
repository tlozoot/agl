class ResultsController < ApplicationController
  
  before_filter :require_user
  
  def index
    @participants = Participant.all
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
end
