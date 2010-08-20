class AddTrainingGroupToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :training_group, :string
  end

  def self.down
    remove_column :participants, :training_group
  end
end
