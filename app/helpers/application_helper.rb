module ApplicationHelper
  
  # Thanks Max! no idea how this works =]
  def html_to_json(&block)
    @template_format = :html
    result = block.call
    @template_format = :json
    return result.to_json
  end
  
  def play_again(result, form)
    content_tag(:span, :class => "linkish play_again #{form.to_s}", 'data-id' => result.paradigm.method(form).call, \
        'data-soundFile' => result.paradigm.method("#{form}_sound_file").call) do
      "play again"
    end
  end
  
  def soundmanager_url
    if url_base =~ /phonetics.fas.harvard.edu/
      "/agl/soundmanager2.swf"
    else
      "/soundmanager2.swf"
    end
  end

  def hebrew_plural(participant, paradigm)
    case participant.training_group
    when 'surface'
      case paradigm.vowel
      when 'o'
        paradigm.singular.sub('o', 'i') + 'im'
      when 'i'
        paradigm.singular.sub('i', 'o') + 'ot'
      end
    when 'deep'
      case paradigm.vowel
      when 'o'
        paradigm.singular.sub('o', 'i') + 'ot'
      when 'i'
        paradigm.singular.sub('i', 'o') + 'im'
      end
    end
  end
  
end
