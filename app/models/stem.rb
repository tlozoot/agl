class Stem < ActiveRecord::Base
  
  has_many :results
  has_many :participants, :through => :results
  
  attr_accessor :display_order, :experiment_phase, :clipart, :response
  
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
