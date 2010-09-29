class ResultsController < ApplicationController
  
  before_filter :require_user
  
  def index
    @participants = Participant.all
    @results = @participants.map(&:results).flatten
    respond_to do |format|
      format.html
      format.csv { @filename = 'results.csv'; render :layout => false }
    end
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
end
