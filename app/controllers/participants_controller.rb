class ParticipantsController < ApplicationController
  layout 'application'
  
  def index
    @participants = Participant.all
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
  
  def new
    @participant = Participant.new
    @participant.training_group = if rand > 0.5 then 'iamb' else 'trochee' end
  end
  
  def create
  end
  
end
