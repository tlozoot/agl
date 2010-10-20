
@lines = IO.read("#{RAILS_ROOT}/lib/hebrew_items.txt").split("\n")

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