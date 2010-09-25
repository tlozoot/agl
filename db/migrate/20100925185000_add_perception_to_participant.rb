class AddPerceptionToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :perception, :string
  end

  def self.down
    remove_column :participants, :perception
  end
end
