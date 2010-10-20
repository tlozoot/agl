class AddExperimentToClipart < ActiveRecord::Migration
  def self.up
    add_column :cliparts, :experiment, :string
    Clipart.reset_column_information
  end

  def self.down
    remove_column :cliparts, :experiment
  end
end
