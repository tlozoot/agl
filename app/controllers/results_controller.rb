class ResultsController < ApplicationController
  
  before_filter :require_user, :except => :index
  
  def index
    # results.csv?id=super_secret_code&exp_type=hebrew
    
    @participants = Participant.all.select{ |p| p.finished? && p.perception != 'wugster' }
    
    if exp_type = params[:exp_type]
      @participants = @participants.select{ |p| p.experiment_type == exp_type.capitalize }
    end
    
    @results = @participants.map(&:results).flatten
    
    begin
      respond_to do |format|
        format.html do
          if current_user then render
          else raise NoPermissionError
          end
        end
        format.csv do
          if current_user || params[:id] == "super_secret_code"
            render(:content_type => "text/csv", :layout => false) # and return
          else raise NoPermissionError            
          end
        end
      end
    rescue
      flash[:message] = "Sorry, you need to log in or provide a valid access code."
      redirect_to login_url
    end
    
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
end
