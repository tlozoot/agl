class Clipart < ActiveRecord::Base
  
  def singular_file
    "/clipart/#{name}1.jpg"
  end
  
  def plural_file
    "/clipart/#{name}2.jpg"
  end
  
end