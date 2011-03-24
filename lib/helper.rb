# coding: utf-8
class Helper
  include Singleton
  include ApplicationHelper
  
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
          .sub('f', 'פ').sub('v', 'ב').sub('h', 'ה') \
          .sub('t', 'ט').sub('c', 'צ').sub('d', 'ד') \
          .sub('s', 'ס').sub('z', 'ז') \
          .sub('x', 'כ').sub('k', 'ק').sub('g', 'ג') \
          .gsub('m', 'מ').sub('n', 'נ').sub('l', 'ל').sub('r', 'ר') \
          .sub(/כ$/, 'ך').gsub(/מ$/, 'ם').sub(/ט$/, 'ת') \
          .sub(/נ$/, 'ן').sub(/פ$/, 'ף').sub(/צ$/, 'ץ')
  end
end

def help
  Helper.instance
end