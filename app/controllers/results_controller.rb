class ResultsController < ApplicationController
  
  before_filter :require_user, :except => :index
  
  def index
    @participants = Participant.all.select{ |p| p.finished? && p.perception != 'wugster' }
    
    if exp_type = params[:exp_type]
      @participants = @participants.select{ |p| p.experiment_type == exp_type.capitalize }
    end
    
    @results = @participants.map(&:results).flatten
    
    if current_user
      respond_to do |format|
        format.html
        format.csv { @filename = 'results.csv'; render :layout => false }
      end
    elsif params[:id] == "super_secret_code"
      respond_to do |format|
        format.csv { @filename = 'results.csv'; render :layout => false }
      end
    else
      flash[:message] = "Sorry, you need to log in or provide a valid access code."
      redirect_to login_url
    end
  end
  
  def results
    respond_to do |format|
      format.html
      format.csv { @filename = 'results.csv'; render :layout => false }
    end
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
end
