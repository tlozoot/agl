class ExperimentsController < ApplicationController
  
  layout 'application'
  
  def index
    @fixes = Fixed.all
    @vars = Variable.all
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
  
  def new
    @participant = Participant.new
  end
  
  def create
    @participant = Participant.new(params[:participant])
    @participant.assign_training_group
    
    if @participant.save
      @participant.generate_items
      redirect_to experiment_training_url(@participant)
    else
      flash.now[:message] = "Whoops--we had a problem saving your results."
      render :new
    end
  end

end
