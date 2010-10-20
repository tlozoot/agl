class Result < ActiveRecord::Base

  require 'lib/helper'

  belongs_to :paradigm
  belongs_to :participant
  belongs_to :clipart
    
  validates_presence_of :paradigm, :participant
  
  def to_s
    paradigm.to_s.chomp + "
    Order: #{display_order}
    Phase: #{experiment_phase}
    Singular: #{singular_response}
    Plural: #{plural_response}"
  end
  
  def human_singular
    case participant.experiment_type
    when 'Hebrew'
      help.to_hebrew(paradigm.singular)
    else
      paradigm.singular
    end
  end
  
  def plural
    case participant.experiment_type
    when 'Hebrew'
      help.hebrew_plural(participant, paradigm)
    else
      paradigm.plural
    end
  end
  
  def human_plural
    case participant.experiment_type
    when 'Hebrew'
      help.to_hebrew(plural)
    else
      paradigm.plural
    end
  end
  
  def plural_sound_file
    "http://phonetics.fas.harvard.edu/agl/stimuli/#{paradigm.experiment_type}/#{plural}.mp3"
  end

end
