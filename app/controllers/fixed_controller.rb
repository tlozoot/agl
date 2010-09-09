class FixedController < ApplicationController
  def show
    @participant = Participant.new(:code => Participant.generate_code)
    @participant.experiment_type = 'fixed'
    render 'experiments/new'
  end
end
