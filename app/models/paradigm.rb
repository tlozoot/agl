class Paradigm < ActiveRecord::Base
  
  has_many :results
  has_many :participants, :through => :results
  
  require "#{RAILS_ROOT}/lib/helper"
  
  attr_accessor :clipart
  
  def self.assign_pictures_to_paradigms_of_type(type)
    type = type.to_s.downcase
    @clipart = Clipart.all.sort_by{ rand }
    if type == 'hebrew'
      @clipart = @clipart.select{ |c| c.experiment == 'hebrew' }
    else 
      @clipart = @clipart.reject{ |c| c.experiment == 'hebrew' }
    end
    Paradigm.find(:all, :conditions => { :experiment_type => type, }) \
        .reject{ |paradigm| (paradigm.singular == 'larb_d') || (paradigm.stress == 'trochee') && (type == 'variable') } \
        .sort_by{ rand } \
        .each{ |paradigm| paradigm.clipart = @clipart.shift }
  end
  
  def to_s
    "Singular: #{ singular }
    Plural: #{ plural }
    Vowel: #{ vowel }
    Consonant: #{ consonant}
    Stress: #{ stress }
    Experiment: #{ experiment_type }
    Experiment group: #{ experiment_group }\n"
  end
  
  def singular_sound_file
    "http://phonetics.fas.harvard.edu/agl/stimuli/#{experiment_type}/#{singular}.mp3"
  end
  
  def plural_sound_file
    "http://phonetics.fas.harvard.edu/agl/stimuli/#{experiment_type}/#{plural}.mp3"
  end
  
  def human_singular
    case experiment_type
    when 'fixed','variable'
      singular.sub('_', '-').sub('x', 'ai')
	  when 'hebrew'
	    help.to_hebrew(singular)
	  end
  end
  
  def human_plural
    plural.sub('_', '-').sub('x', 'ai')
  end
  
  def plural
    case experiment_type
    when 'fixed'
      case vowel
      when 'u'
        singular.sub('u', 'i')
      when 'e'
        singular.sub('e', 'o')
      else
        singular + 'ni'
      end
    when 'variable'
      (case consonant
      when 'p'
        singular.sub(/p$/, 'b')
      when 't'
        singular.sub(/t$/, 'd')
      when 'k'
        singular.sub(/k$/, 'g')
      else
        singular
      end) + 'ni'
    when 'hebrew'
      "Surface: #{help.hebrew_plural(:surface, self)}, Deep: #{help.hebrew_plural(:deep, self)}"
    end
  end
  
end
