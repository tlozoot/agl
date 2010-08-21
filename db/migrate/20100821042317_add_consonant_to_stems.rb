class AddConsonantToStems < ActiveRecord::Migration
  def self.up
    add_column :stems, :consonant, :string
  end

  def self.down
    remove_column :stems, :consonant
  end
end
