# coding: utf-8

class Paradigm < ActiveRecord::Base
  
  has_many :results
  has_many :participants, :through => :results
  
  attr_accessor :clipart
  
  def self.assign_pictures_to_paradigms_of_type(type)
    @clipart = Clipart.all.sort_by{ rand }
    @clipart.reject!{ |c| c.experiment == 'hebrew' } if type != 'hebrew'
    Paradigm.find(:all, :conditions => { :experiment_type => type.to_s.downcase, }) \
        .reject{ |paradigm| (paradigm.singular == 'larb_d') || (paradigm.stress == 'trochee') && (type.to_s.downcase == 'variable') } \
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
        singular.sub('a', 'א') \
        .sub('i', 'י') \
        .sub('o', 'ו') \
        .sub('sh', 'ש') \
        .sub('p', 'פ') \
        .sub('b', 'ב') \
        .sub('f', 'פ') \
        .sub('v', 'ב') \
        .sub('t', 'ט') \
        .sub('c', 'צ') \
        .sub('d', 'ד') \
        .sub('s', 'ס') \
        .sub('z', 'ז') \
        .sub('x', 'כ') \
        .sub('k', 'ק') \
        .sub('g', 'ג') \
        .sub('m', 'מ') \
        .sub('n', 'נ') \
        .sub('l', 'ל') \
        .sub('r', 'ר') \
        .sub(/כ$/, 'ך') \
        .sub(/מ$/, 'ם') \
        .sub(/נ$/, 'ן') \
        .sub(/פ$/, 'ף') \
        .sub(/צ$/, 'ץ') 
  	end
  end
  
  def human_plural
    if plural
      plural.sub('_', '-').sub('x', 'ai')
    end
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
      nil
    end
  end
  
end
