class MakeStemsIntoParadigms < ActiveRecord::Migration
  def self.up
    rename_table :stems, :paradigms
    rename_column :results, :stem_id, :paradigm_id
  end

  def self.down
    rename_table :paradigms, :stems
    rename_column :results, :paradigm_id, :stem_id
  end
end
