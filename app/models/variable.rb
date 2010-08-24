class Variable < Participant
    
  def self.pick_training_group
    rand > 0.5 ? 'iamb' : 'mono'
  end
  
  private
  
  def control_words
    @stems.select{ |stem| stem.singular =~ /(r|l|m|ng)$/ }
  end
  
  def testing_words
    @stems.select{ |stem| stem.singular =~ /(p|t|k)$/ }
  end
  
  def training_items
    ['l', 'm', 'r'].map do |c|
      stem = @stems.select{ |s| s.consonant == c }.first
      stem.experiment_phase = 'training'
      stem
    end
  end
  
end