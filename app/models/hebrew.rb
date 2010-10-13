class Hebrew < Participant
  
  def groups
    ['surf', 'deep']
  end
  
  private
  
  def control_words
    @paradigms.select{ |paradigm| paradigm.singular =~ /a/ }
  end
  
  def training_items
    @paradigms.select{ |s| s.vowel == 'a' }.sort_by{ rand }.first(3)
  end
  
  def places_of_articulation
    {
      'i' => 5,
      'o' => 5
    }
  end
  
  def control_places
    ''
  end
  
  def independent_variable
    'vowel'
  end
  
  def opposite_training_group
    (training_group == 'surf') ? 'deep' : 'surf'
  end
  
  
end