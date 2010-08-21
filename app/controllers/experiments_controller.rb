class ExperimentsController < ApplicationController
  
  layout 'application'
  
  def index
    @fixes = Fixed.all
    @vars = Variable.all
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
  
  def new
    
    
  end
  
  def create
    if @participant.save
      render root_url
    else
      redirect_to root_url
    end
  end
  

end
