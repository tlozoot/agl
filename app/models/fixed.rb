class Fixed < Participant

  def assign_training_group
    self.training_group = (rand > 0.5 ? 'iamb' : 'trochee')
  end
  
  private
  
  def control_words
    @stems.select{ |stem| stem.singular =~ /a/ }
  end
  
  def testing_words
    @stems.select{ |stem| stem.singular =~ /(e|u)$/ }
  end
  
  def training_items
    @stems.select{ |s| s.vowel == 'a' }.sort_by{ rand }.first(3)
  end
  
end