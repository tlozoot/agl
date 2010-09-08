@paradigms = IO.read("/Users/jonathan/Dropbox/fAGL01 materials/matt1labels").split("\n").reject { |paradigm| paradigm =~ /i|o/ }

@paradigms.each do |singular|
  paradigm = Paradigm.new do |s|
    s.singular = singular
    s.plural = singular.sub('u', 'i').sub('e', 'o')
    s.vowel = singular.match(/a|e|u/).to_s
    s.stress = if singular =~ /_.*(a|e|u)/ then "iamb" else "trochee" end
    s.experiment_type = "fixed"
  end
  paradigm.save
end