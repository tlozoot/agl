class ExperimentsController < ApplicationController
  
  layout 'application'
  
  def index
    @fixes = Fixed.all
    @vars = Variable.all
  end

end
