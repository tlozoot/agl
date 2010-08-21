class ExperimentsController < ApplicationController
  
  layout 'application'
  
  def index
    @fixes = Fixed.all
    @vars = Variable.all
  end
  
  def create
    if @participant.save
      render root_url
    else
      redirect_to root_url
    end
  end
  

end
