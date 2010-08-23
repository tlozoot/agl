class ResultsController < ApplicationController
  def index
    @vars = Variable.all
    @fixes = Fixed.all
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
end
