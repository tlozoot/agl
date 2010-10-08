# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101008183833) do

  create_table "cliparts", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "paradigms", :force => true do |t|
    t.string    "singular"
    t.string    "spelled_plural"
    t.string    "vowel"
    t.string    "stress"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "experiment_type"
    t.string    "consonant"
    t.string    "spelled_singular"
  end

  create_table "participants", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "training_group"
    t.string   "experiment_type"
    t.integer  "experiment_position", :default => 1
    t.string   "perception"
    t.integer  "year_born"
    t.string   "language_background"
    t.string   "email"
    t.text     "comments"
    t.string   "other_languages"
    t.boolean  "native"
    t.string   "gender"
  end

  create_table "results", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "paradigm_id"
    t.integer  "display_order"
    t.string   "experiment_phase"
    t.string   "plural_response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "clipart_id"
    t.string   "singular_response"
    t.boolean  "both_responses",      :default => false
    t.integer  "singular_play_count", :default => 0
    t.integer  "plural_play_count",   :default => 0
  end

  create_table "users", :force => true do |t|
    t.string    "username"
    t.string    "crypted_password"
    t.string    "password_salt"
    t.string    "persistence_token"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
