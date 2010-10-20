class Hebrew < Participant
  
  def groups
    ['surface', 'deep']
  end
  
  def generate_items
    assign_training_group
    @paradigms = Paradigm.assign_pictures_to_paradigms_of_type("hebrew")
    
    @items = {}
    @items[:learning] = @paradigms.select{ |p| p.experiment_group == 'training'}.sort_by{ rand }
    @items[:testing] = @paradigms.select{ |p| p.experiment_group == 'testing'}.sort_by{ rand }
    
    @bools = {}
    @bools[:learning] = Array.new(5, false) + Array.new(5, true) # spell the latter half of the learning words
    @bools[:testing] = Array.new(10, false) + Array.new(10, true) # hide the singulars in latter half of the testing
      
    [:learning, :testing].each do |phase|
      @items[phase].sort_by{ rand }.each do |item|
        self.results.create(:paradigm => item, :clipart => item.clipart, :experiment_phase => phase.to_s, :both_responses => @bools[phase].shift)
      end
    end
    
    self.results.each_with_index do |result, i|
      result.display_order = i + 1
      result.save
    end
    
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
    (training_group == 'surface') ? 'deep' : 'surface'
  end
  
end