class ChangePluralToSpelledPlural < ActiveRecord::Migration
  def self.up
    rename_column :paradigms, :plural, :spelled_plural
  end

  def self.down
    rename_column :paradigms, :spelled_plural, :plural
  end
end
