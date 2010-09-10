class ExperimentsController < ApplicationController
  
  layout 'application'
  before_filter :get_participant, :only => [:show, :update]
  
  def index
    redirect_to :action => :new
  end
  
  def new
    @participant = Participant.new(:code => Participant.generate_code)
  end
  
  def create
    @participant = params[:participant][:experiment_type].capitalize.constantize.new(params[:participant])
    @participant.assign_training_group
    if @participant.save
      @participant.generate_items
      redirect_to experiment_training_url(@participant)
    else
      flash.now[:message] = "Sorry, we had a problem starting your experiment."
      render :new
    end
  end
  
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
      if next_result.nil?
        render :finished
      else
        if @result.experiment_phase != next_result.experiment_phase
          render next_result.experiment_phase
        else
          redirect_to experiment_url(@participant)
        end
      end
    else
      flash.now[:message] = "Sorry--try again."
      render :show
    end
  end
  
  def training 
    @participant = Participant.find(params[:experiment_id])
  end
  
  def training_test ; end
  
  def learning ; end
  
  def testing ; end
  
  def finished ; end

  private
  
  def get_participant
    @participant = Participant.find(params[:id])
  end
  

end
