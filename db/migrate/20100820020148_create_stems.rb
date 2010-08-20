class CreateStems < ActiveRecord::Migration
  def self.up
    create_table :stems do |t|
      t.string :singular
      t.string :plural
      t.string :vowel
      t.string :stress
      t.timestamps
    end
  end

  def self.down
    drop_table :stems
  end
end
