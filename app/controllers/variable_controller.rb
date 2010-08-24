class VariableController < ApplicationController
  def show
    @participant = Participant.new
    @participant.experiment_type = 'variable'
    render 'experiments/new'
  end
end
