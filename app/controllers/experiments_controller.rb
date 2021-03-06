class ExperimentsController < ApplicationController
  
  layout 'application'
  before_filter :get_participant, :only => [:show, :update]
  before_filter :get_participant_id, :only => [:training, :training_test, :learning, :testing, :finished, :spelling]
  
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
      respond_to do |format|
        format.html { render :spelling }
        format.json { 
          @result = @participant.results.first
          render :spelling, :layout => false
        }
      end  
    else
      flash.now[:message] = "Sorry, we had a problem starting your experiment."
      render :new
    end
  end
  
  def show
    respond_to do |format|
      unless @result = @participant.results.find_by_display_order(@participant.experiment_position)
        format.html { render :finished }
      end
      format.html
      format.json { render :layout => false }
    end
  end
  
  def update
    @previous_result = @participant.results.find(params[:result][:id])
    @participant.experiment_position += 1
    if @participant.save
      case @previous_result.experiment_phase
      when 'learning'
        @previous_result.update_attributes params[:result]
      when 'testing', 'training_test'
        if @previous_result.plural_response.nil?
          @previous_result.update_attributes params[:result]
        else  
          flash.now[:message] = "Sorry, you can't change your responses."
          redirect_to experiment_url(@participant)
        end
      end
      @result = @participant.results.find_by_display_order(@participant.experiment_position)
      if @result.nil?
         respond_to do |format|
            format.html { render :finished }
            format.json { render :finished, :layout => false }
          end
      else
        respond_to do |format|
          format.html { redirect_to experiment_url(@participant) }
          format.json { render :layout => false }
        end
      end
    else
      flash.now[:message] = "Sorry--try again."
      render :show
    end
  end
  
  def training 
    @result = @participant.results.first
    respond_to do |format|
      format.json { 
        render :partial => 'screen', :layout => false
      }
    end
  end
  
  def training_test ; end
  
  def learning
    @result = @participant.results.first
    respond_to do |format|
      format.json { 
        render :partial => 'screen', :layout => false
      }
    end
  end
  
  def testing ; end
  
  def finished ; end
  
  def spelling
    @result = @participant.results.first
  end

  private
  
  def get_participant
    @participant = Participant.find(params[:id]) 
  end
  
  def get_participant_id
    @participant = Participant.find(params[:experiment_id])
  end
  

end
