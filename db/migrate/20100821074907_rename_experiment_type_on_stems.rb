class RenameExperimentTypeOnStems < ActiveRecord::Migration
  def self.up
    rename_column :stems, :experiment, :experiment_type
  end

  def self.down
    rename_column :stems, :experiment_type, :experiment
  end
end
