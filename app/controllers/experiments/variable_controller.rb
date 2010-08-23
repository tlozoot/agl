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
      item = @participant.items.sort_by{ |a,b| a.display_order <=> b.display_order }.first
      redirect_to experiment_response_url(@participant, )
    else
      flash.now[:message] = "Whoops--we had a problem saving your results."
      render :new
    end
  end
  
  private
  
  def get_training_items
    @training_items = [@stems.select{ |s| s.consonant == 'l' }.first, 
                       @stems.select{ |s| s.consonant == 'm' }.first, 
                       @stems.select{ |s| s.consonant == 'r' }.first]
    assign_phase_and_order(@training_items, 'training')
    # then delete training items?
  end
  
  def load_control_words
    @control_words = @stems.select{ |stem| stem.singular =~ /(r|l|m|ng)$/ }
  end
    
  def load_experimental_words
    @experimental_words = {}
    @experimental_words[:testing]  = @stems.select{ |s| s.singular =~ /(p|t|k)$/ }
    @experimental_words[:learning] = @experimental_words[:testing].deep_copy.select do |s|
      s.stress == @participant.training_group 
    end    
  end
  
  def get_experiment_items(phase)
    @items = @control_words.deep_copy.randomly_pick(5) + @experimental_words[phase].randomly_pick(5) 
    assign_phase_and_order(@items, phase)
  end
  
  def assign_phase_and_order(items, phase)
    items.each_index do |i|
      items[i].experiment_phase = phase.to_s
      items[i].display_order = i + 1
    end
  end
  
end
