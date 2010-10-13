@paradigms = IO.read('/Users/michaelbecker/Documents/Dropbox/Research/AGLs/heb01\ materials/hebrewitems.txt').split("\n")

@paradigms.each do |singular|
  paradigm = Paradigm.new do |s|
    s.singular = singular
    s.vowel = singular.match(/i|o/).to_s
    s.experiment_type = "hebrew"
  end
  puts paradigm
end