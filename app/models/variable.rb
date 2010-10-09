class Variable < Participant
    
  def groups
    ['mono', 'iamb']
  end
  
  private
  
  def control_words
    @paradigms.select{ |paradigm| paradigm.singular =~ /(r|l|m|ng)$/ }
  end
  
  def training_items
    %w(l m r).map do |c|
      paradigm = @paradigms.select{ |s| s.consonant == c }.first
      paradigm
    end
  end
  
  def places_of_articulation
    {
      'p' => 4,
      't' => 3,
      'k' => 3
    }
  end
  
  def control_places
    'r|l|m|ng'
  end
  
  def independent_variable
    'consonant'
  end
  
  def opposite_training_group
    (training_group == 'mono') ? 'iamb' : 'mono'
  end
  
end