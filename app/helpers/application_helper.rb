module ApplicationHelper
  
  # Thanks Max! no idea how this works =]
  def html_to_json(&block)
    @template_format = :html
    result = block.call
    @template_format = :json
    return result.to_json
  end
  
  def play_again(result, form)
    content_tag(:span, :class => "linkish play_again #{form.to_s}", 'data-id' => result.method(form).call, \
        'data-soundFile' => result.method("#{form}_sound_file").call) do
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

  def hebrew_plural(group_or_participant, paradigm)
    group = group_or_participant.is_a?(Participant) ? group_or_participant.training_group : group_or_participant.to_s
    case group
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
  
  def to_hebrew(string)
    # sub out ALL of the vowels... amirite?
    string.gsub('a', 'א').gsub('i', 'י').gsub('o', 'ו') \
          .sub('sh', 'ש') \
          .sub('p', 'פ').sub('b', 'ב') \
          .sub('f', 'פ').sub('v', 'ב') \
          .sub('t', 'ט').sub('c', 'צ').sub('d', 'ד') \
          .sub('s', 'ס').sub('z', 'ז') \
          .sub('x', 'כ').sub('k', 'ק').sub('g', 'ג') \
          .sub('m', 'מ').sub('n', 'נ').sub('l', 'ל').sub('r', 'ר') \
          .sub(/כ$/, 'ך').sub(/מ$/, 'ם') \
          .sub(/נ$/, 'ן').sub(/פ$/, 'ף').sub(/צ$/, 'ץ')
  end
  
end
