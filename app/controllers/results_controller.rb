class ResultsController < ApplicationController
  
  before_filter :require_user, :except => :index
    
  def index
    # results.csv?id=super_secret_code&exp_type=hebrew
    
    @participants = Participant.all.select{ |p| p.finished? && p.perception != 'wugster' }
    
    if exp_type = params[:exp_type]
      @participants = @participants.select{ |p| p.experiment_type == exp_type.capitalize }
    end
  
    if params[:demographics]
      @rows = @participants
      @columns = %w(id created_at year_born language_background email comments other_languages native gender)
    else
      @rows = @participants.map(&:results).flatten
      @columns = %w(participant.perception participant.id participant.code participant.created_at updated_at participant.experiment_type.to_s.downcase participant.training_group experiment_phase display_order paradigm.consonant paradigm.vowel paradigm.stress paradigm.human_singular singular_play_count paradigm.human_plural plural_play_count plural_response both_responses participant.year_born participant.language_background participant.email participant.comments participant.other_languages participant.native participant.gender)
    end
      
    begin
      respond_to do |format|
        format.html do
          if current_user then render
          else raise PermissionError
          end
        end
        format.csv do
          if current_user || params[:id] == "super_secret_code"
            render(:text => help.csv_for(@rows, @columns), :content_type => "text/csv", :layout => false)
          else raise PermissionError            
          end
        end
      end
    rescue PermissionError
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
