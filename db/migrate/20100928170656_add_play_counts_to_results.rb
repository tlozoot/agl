class AddPlayCountsToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :singular_play_count, :integer, :default => 0
    add_column :results, :plural_play_count, :integer, :default => 0
  end

  def self.down
    remove_column :results, :singular_play_count
    remove_column :results, :plural_play_count
  end
end
