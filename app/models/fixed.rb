class Fixed < Participant

  def self.test
    f = Fixed.new(:name => "fixed test")
    f.save
    f.generate_items
    f
  end

  def pick_training_group
    rand > 0.5 ? 'iamb' : 'trochee'
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