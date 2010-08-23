class Variable < Participant
  
  def assign_training_group
    training_group = (rand > 0.5 ? 'iamb' : 'mono')
  end
  
  def generate_items
    assign_training_group if training_group.nil?
    @stems = Stem.assign_pictures_to_stems_of_type(:variable)
    @control_words = @stems.select{ |stem| stem.singular =~ /(r|l|m|ng)$/ }

    @experimental_words = {}
    @experimental_words[:testing]  = @stems.select{ |s| s.singular =~ /(p|t|k)$/ }
    @experimental_words[:learning] = @experimental_words[:testing].deep_copy.select do |s|
      s.stress == training_group  
    end
    
    @training_items = ['l', 'm', 'r'].map do |c|
      stem = @stems.select{ |s| s.consonant == c }.first
      stem.experiment_phase = 'training'
      stem
    end
    
    self.stems << @training_items
    self.stems << get_experiment_items(:learning)
    self.stems << get_experiment_items(:testing)
    
    self.stems.each_index do |i|
      self.stems[i].display_order = i + 1
    end
  end

  private
  
  def get_experiment_items(phase)
    @items = @control_words.deep_copy.randomly_pick(5) + @experimental_words[phase].randomly_pick(5)
    @items.each do |item|
      item.experiment_phase = phase.to_s
    end
  end
  
end