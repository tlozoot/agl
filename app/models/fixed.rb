class Fixed < Participant

  def pick_training_group
    rand > 0.5 ? 'iamb' : 'trochee'
  end
  
  private
  
  def control_words
    @paradigms.select{ |paradigm| paradigm.singular =~ /a/ }
  end
  
  def testing_words
    @paradigms.select{ |paradigm| paradigm.singular =~ /(e|u)/ }
  end
  
  def training_items
    @paradigms.select{ |s| s.vowel == 'a' }.sort_by{ rand }.first(3)
  end
  
end