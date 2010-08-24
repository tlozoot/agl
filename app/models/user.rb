class User < ActiveRecord::Base
  
  acts_as_authentic
  
  attr_accessor :code
  
  before_save :check_code
  
  def check_code
    self.code == "wugster"
  end
  
end
