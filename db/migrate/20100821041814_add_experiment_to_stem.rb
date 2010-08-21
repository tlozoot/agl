class AddExperimentToStem < ActiveRecord::Migration
  def self.up
    add_column :stems, :experiment, :string
  end

  def self.down
    remove_column :stems, :experiment
  end
end
