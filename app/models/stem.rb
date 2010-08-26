class Stem < ActiveRecord::Base
  
  has_many :results
  has_many :participants, :through => :results
  
  attr_accessor :clipart, :experiment_type
  
  def self.assign_pictures_to_stems_of_type(type)
    @clipart = Clipart.all.sort_by{ rand }
    Stem.find(:all, :conditions => { :experiment_type => type.to_s.downcase, }) \
        .reject{ |stem| (stem.stress == 'trochee') && (type.to_s.downcase == 'variable') } \
        .sort_by{ rand } \
        .each{ |stem| stem.clipart = @clipart.shift }
  end
  
  def to_s
    "Singular: #{ singular }
    Plural: #{ plural }
    Vowel: #{ vowel }
    Consonant: #{ consonant}
    Stress: #{ stress }
    Experiment: #{ experiment_type }\n"
  end
  
  def singular_sound_file
    "/stimuli/#{experiment_type}/#{singular}.mp3"
  end
  
  def plural_sound_file
    "/stimuli/#{experiment_type}/#{plural}.mp3"
  end
  
end
