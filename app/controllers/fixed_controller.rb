class FixedController < ApplicationController
  def show
    @participant = Participant.new
    @participant.experiment_type = 'fixed'
    render 'experiments/new'
  end
end
