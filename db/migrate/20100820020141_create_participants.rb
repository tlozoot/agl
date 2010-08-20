class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name
      t.string :code
      t.string :location
      t.integer :age
      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
