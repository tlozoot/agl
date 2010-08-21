@stems = IO.read("/Users/jonathan/Dropbox/fAGL01 materials/matt1labels").split("\n").reject { |stem| stem =~ /i|o/ }

@stems.each do |singular|
  stem = Stem.new do |s|
    s.singular = singular
    s.plural = singular.sub('u', 'i').sub('e', 'o')
    s.vowel = singular.match(/a|e|u/).to_s
    s.stress = if singular =~ /_.*(a|e|u)/ then "iamb" else "trochee" end
    s.experiment = "fixed"
  end
  stem.save
end