class AddClipartToResult < ActiveRecord::Migration
  def self.up
    add_column :results, :clipart_id, :integer
  end

  def self.down
    remove_column :results, :clipart_id
  end
end
