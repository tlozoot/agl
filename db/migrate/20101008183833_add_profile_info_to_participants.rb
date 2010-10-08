class AddProfileInfoToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :language_background, :string
    add_column :participants, :email, :string
    add_column :participants, :comments, :text
    add_column :participants, :other_languages, :string
    add_column :participants, :native, :boolean
    add_column :participants, :gender, :string
    rename_column :participants, :age, :year_born
  end

  def self.down
    remove_column :participants, :language_background
    remove_column :participants, :email
    remove_column :participants, :comments
    remove_column :participants, :other_languages
    remove_column :participants, :native
    remove_column :participants, :gender
    rename_column :participants, :year_born, :age
  end
end
