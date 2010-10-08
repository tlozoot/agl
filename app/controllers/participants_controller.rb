class ParticipantsController < ApplicationController
  
  def update
    @participant = Participant.find(params[:id])
    @params = params[:fixed] || params[:variable]
    if @participant.update_attributes(@params)
      respond_to do |format|
        format.js { render :layout => false }
      end
    else
      flash[:message] = "Sorry, we had trouble saving your results."
      render 'experiments/finished'
    end
  end

end
