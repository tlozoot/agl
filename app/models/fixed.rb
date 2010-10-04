class Fixed < Participant

  def pick_training_group
    rand > 0.5 ? 'iamb' : 'trochee'
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
      'e' => 5,
      'u' => 5
    }
  end
  
  def control_places
    'a'
  end
  
  def independent_variable
    'vowel'
  end
  
  def opposite_training_group
    (training_group == 'iamb') ? 'trochee' : 'iamb'
  end
  
  
end