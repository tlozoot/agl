class AddExperimentTypeToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :experiment_type, :string
  end

  def self.down
    remove_clumn :participants, :experiment_type
  end
end
