class ParticipantsController < ApplicationController
  
  layout 'application'
  
  def update
    @participant = Participant.find(params[:id])
    @params = params[:fixed] || params[:variable]
    if @participant.update_attributes(@params)
      respond_to do |format|
        format.html { render :show }
        format.js { render :layout => false }
      end
    else
      flash[:message] = "Sorry, we had trouble saving your results."
      render 'experiments/finished'
    end
  end
  
  def show
    @participant = Participant.find(params[:id])
  end

end
