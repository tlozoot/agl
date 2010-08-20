class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :participant_id
      t.integer :stem_id
      t.integer :display_order
      t.string :experiment_phase
      t.string :response
      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
