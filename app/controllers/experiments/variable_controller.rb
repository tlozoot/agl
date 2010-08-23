class Experiments::VariableController < ExperimentsController
  
  def index
    @variables = Variable.all
  end
  
  def show
    @variable = Variable.find(params[:id])
  end
  
  def new
    @participant = Variable.new
  end
  
  def create
    @participant = Variable.new(params[:variable])
    @participant.assign_training_group
    @participant.generate_items
    
    if @participant.save
      redirect_to experiment_response_url(@participant, @participant.items[1])
    else
      flash.now[:message] = "Whoops--we had a problem saving your results."
      render :new
    end
  end
  
end
