class Stem < ActiveRecord::Base
  
  has_many :results
  has_many :participants, :through => :results
  
  attr_accessor :display_order, :experiment_phase, :clipart
  
  def to_s
    "Singular: #{ self.singular }
    Plural: #{ self.plural }
    Vowel: #{ self.vowel }
    Stress: #{ self.stress }\n"
  end
  
  def singular_sound_file
    "/stimuli/#{singular}.mp3"
  end
  
  def plural_sound_file
    "/stimuli/#{plural}.mp3"
  end
  
end
