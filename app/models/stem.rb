class Stem < ActiveRecord::Base
  def to_s
    "Singular: #{ self.singular }
    Plural: #{ self.plural }
    Vowel: #{ self.vowel }
    Stress: #{ self.stress }\n"
  end
end
