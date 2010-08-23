class Variable < Participant
  
  def self.test
    Variable.all.each(&:destroy)
    Result.all.each(&:destroy)
    v = Variable.new(:name => "clean test")
    v.save
    v.generate_items
    v.results
    v
  end
  
  def assign_training_group
    self.training_group = (rand > 0.5 ? 'iamb' : 'mono')
  end
  
  def generate_items
    self.assign_training_group if self.training_group.nil?
    @stems = Stem.assign_pictures_to_stems_of_type(:variable)
    @control_words = @stems.select{ |stem| stem.singular =~ /(r|l|m|ng)$/ }

    @experimental_words = {}
    @experimental_words[:testing]  = @stems.select{ |s| s.singular =~ /(p|t|k)$/ }
    @experimental_words[:learning] = @experimental_words[:testing].deep_copy.select do |s|
      s.stress == self.training_group  
    end
    
    @items = {}
    @items = {
      :training => get_training_items,
      :learning => get_experiment_items(:learning),
      :testing  => get_experiment_items(:testing),
    }
    
    [:training, :learning, :testing].each do |phase|
      @items[phase].each do |item|
        self.results.create(:stem => item, :clipart => item.clipart, :experiment_phase => phase.to_s)
      end
    end
    
    self.results.each_index do |i|
      self.results[i].display_order = i + 1
      self.results[i].save
    end
  end

  private
  
  def get_training_items
    ['l', 'm', 'r'].map do |c|
      stem = @stems.select{ |s| s.consonant == c }.first
      stem.experiment_phase = 'training'
      stem
    end
  end
  
  def get_experiment_items(phase)
    @items = @control_words.deep_copy.randomly_pick(5) + @experimental_words[phase].randomly_pick(5)
    @items.each do |item|
      item.experiment_phase = phase.to_s
    end
  end
  
end