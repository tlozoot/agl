class AddExperimentPositionToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :experiment_position, :integer, :default => 1
  end

  def self.down
    remove_column :participants, :experiment_position
  end
end
