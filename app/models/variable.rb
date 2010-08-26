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
    @stems.select{ |stem| stem.singular =~ /(r|l|m|ng)$/ }
  end
  
  def testing_words
    @stems.select{ |stem| stem.singular =~ /(p|t|k)$/ }
  end
  
  def training_items
    ['l', 'm', 'r'].map do |c|
      stem = @stems.select{ |s| s.consonant == c }.first
      stem
    end
  end
  
end