class ExperimentsController < ApplicationController
  
  layout 'application'
  
  def index
    redirect_to :action => :new
  end
  
  def new
    @participant = Participant.new
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

end
