class CreateCliparts < ActiveRecord::Migration
  def self.up
    create_table :cliparts do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :cliparts
  end
end
