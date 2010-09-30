class Fixed < Participant

  def pick_training_group
    # rand > 0.5 ? 'iamb' : 'trochee'
    'iamb'
  end
  
  private
  
  def control_words
    @paradigms.select{ |paradigm| paradigm.singular =~ /a/ }
  end
  
  def training_items
    @paradigms.select{ |s| s.vowel == 'a' }.sort_by{ rand }.first(3)
  end
  
  def places_of_articulation
    %w(e u)
  end
  
  def independent_variable
    'vowel'
  end
  
end