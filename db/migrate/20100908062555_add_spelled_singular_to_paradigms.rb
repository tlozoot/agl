class AddSpelledSingularToParadigms < ActiveRecord::Migration
  def self.up
    add_column :paradigms, :spelled_singular, :string
  end

  def self.down
    remove_column :paradigms, :spelled_singular
  end
end
