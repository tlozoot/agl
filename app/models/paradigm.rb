class Paradigm < ActiveRecord::Base
  
  has_many :results
  has_many :participants, :through => :results
  
  attr_accessor :clipart
  
  def self.assign_pictures_to_paradigms_of_type(type)
    @clipart = Clipart.all.sort_by{ rand }
    Paradigm.find(:all, :conditions => { :experiment_type => type.to_s.downcase, }) \
        .reject{ |paradigm| (paradigm.stress == 'trochee') && (type.to_s.downcase == 'variable') } \
        .sort_by{ rand } \
        .each{ |paradigm| paradigm.clipart = @clipart.shift }
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
  
  def spelled_plural
    case experiment_type
    when 'fixed'
      case vowel
      when 'u'
        spelled_singular.sub('u', 'i')
      when 'e'
        spelled_singular.sub('e', 'o')
      else
        spelled_singular + 'ni'
      end
    when 'variable'
      (case consonant
      when 'p'
        spelled_singular.sub(/p$/, 'b')
      when 't'
        spelled_singular.sub(/t$/, 'd')
      when 'k'
        spelled_singular.sub(/k$/, 'g')
      else
        spelled_singular
      end) + 'ni'
    end
  end
  
end
