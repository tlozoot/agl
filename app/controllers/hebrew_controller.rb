class HebrewController < ApplicationController
  def show
    @participant = Participant.new(:code => Participant.generate_code)
    @participant.experiment_type = 'hebrew'
    render 'hebrew/new'
  end
end
