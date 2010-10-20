class Clipart < ActiveRecord::Base
  
  has_many :results
  
  def singular_file
    "http://phonetics.fas.harvard.edu/agl/clipart/#{experiment_path}#{name}1.jpg"
  end
  
  def plural_file
    "http://phonetics.fas.harvard.edu/agl/clipart/#{experiment_path}#{name}2.jpg"
  end
  
  def experiment_path
    if experiment.blank?
      ''
    else
      "#{experiment}/"
    end
  end
  
end