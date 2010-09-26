class AddSingularResponseToResults < ActiveRecord::Migration
  def self.up
    rename_column :results, :response, :plural_response
    add_column :results, :singular_response, :string
    add_column :results, :both_responses, :boolean, :default => false
  end

  def self.down
    rename_column :results, :plural_response, :response
    remove_column :results, :singular_response
    remove_column :results, :both_responses
  end
end
