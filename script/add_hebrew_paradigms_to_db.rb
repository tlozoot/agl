@michaels_file = '/Users/michaelbecker/Documents/Dropbox/Research/AGLs/heb01\ materials/hebrewitems.txt'
@jons_file = '/Users/jonathan/Desktop/hebrewitems.txt'

@lines = IO.read(@jons_file).split("\n")

@lines.each do |line|
  singular, experiment_group = line.split('_')
  paradigm = Paradigm.new do |s|
    s.singular = singular
    s.vowel = singular.match(/i|o/).to_s
    s.experiment_type = "hebrew"
    s.experiment_group = experiment_group
  end
  paradigm.save
end