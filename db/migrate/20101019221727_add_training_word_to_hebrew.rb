class AddTrainingWordToHebrew < ActiveRecord::Migration
  def self.up
    add_column :paradigms, :experiment_group, :string
  end

  def self.down
    remove_column :paradigms, :experiment_group
  end
end
