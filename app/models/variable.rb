class Variable < Participant
    
  def self.test
    v = Variable.new
    v.name = "variable test"
    v.save
    v.generate_items
    v
  end  
    
  def pick_training_group
    rand > 0.5 ? 'iamb' : 'mono'
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