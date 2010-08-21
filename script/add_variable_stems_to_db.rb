@lines = IO.read("/Users/jonathan/Dropbox/sites/varAGL01/stimuli.txt").split("\n").map{ |l| l.split("\t") }

@lines.each do |line|
  stem = Stem.new do |s|
    s.singular, s.consonant, s.stress, s.vowel, s.plural = line
    s.experiment = "variable"
  end
  stem.save
end