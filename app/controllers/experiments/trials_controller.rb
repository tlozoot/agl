class Experiments::TrialsController < ApplicationController
 
  before_filter :get_participant
  
  def show
    unless @result = @participant.results.find_by_display_order(@participant.experiment_position)
      render :finished
    end
  end
  
  def update
    @result = @participant.results.find_by_display_order(@participant.experiment_position)
    @participant.experiment_position += 1
    if @participant.save
      case @result.experiment_phase
      when 'testing', 'training_test'
        @result.update_attributes params[:result]
      end
      next_result = @participant.results.find_by_display_order(@participant.experiment_position)
      unless next_result.nil?
        if @result.experiment_phase != next_result.experiment_phase
          redirect_to :action => next_result.experiment_phase
        else
          redirect_to experiment_trials_url(@participant)
        end
      else
        render :finished
      end
    else
    end
  end
  
  def training 
    get_next_result(:training)
  end
  
  def training_test
    get_next_result(:training_test)
  end
  
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
