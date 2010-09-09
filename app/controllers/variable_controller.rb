class VariableController < ApplicationController
  def show
    @participant = Participant.new(:code => Participant.generate_code)
    @participant.experiment_type = 'variable'
    render 'experiments/new'
  end
end
