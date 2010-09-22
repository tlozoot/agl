class Clipart < ActiveRecord::Base
  
  has_many :results
  
  def singular_file
    "http://phonetics.fas.harvard.edu/AGL/clipart/#{name}1.jpg"
  end
  
  def plural_file
    "http://phonetics.fas.harvard.edu/AGL/clipart/#{name}2.jpg"
  end
  
end