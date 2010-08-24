class ResultsController < ApplicationController
  
  before_filter :require_user
  
  def index
    @fixes = Fixed.all
    @vars = Variable.all
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
end
