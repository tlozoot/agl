class Experiments::VariableController < ExperimentsController
  
  def index
    @variables = Variable.all
  end
  
  
  def show
    @variable = Variable.find(params[:id])
  end
  
  def new
    get_new_participant
    assign_pictures_to_stems
    load_control_words
    load_experimental_words
    
    @participant.stems << get_training_items
    @participant.stems << get_experiment_items(:learning)
    @participant.stems << get_experiment_items(:testing)
  end
  
  def create
    @participant = Variable.new(params[:variable])
    if @participant.save     
      flash[:message] = "Thanks for your participation!"
      redirect_to result_url(@participant)
    else
      flash.now[:message] = "Whoops--we had a problem saving your results."
      render :new
    end
  end
  
  private
  
  def get_new_participant
    @participant = Variable.new(:training_group => (rand > 0.5 ? 'iamb' : 'mono'))
  end
  
  def assign_pictures_to_stems
    @clipart = Clipart.all.sort_by{ rand }
    @stems = Stem.find(:all, :conditions => { :experiment_type => 'variable', }) \
                 .reject{ |stem| stem.stress == 'trochee' } \
                 .sort_by{ rand } \
                 .each{ |stem| stem.clipart = @clipart.shift }
  end
  
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
