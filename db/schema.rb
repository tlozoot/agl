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

ActiveRecord::Schema.define(:version => 20100820063627) do

  create_table "participants", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "location"
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "training_group"
  end

  create_table "results", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "stem_id"
    t.integer  "display_order"
    t.string   "experiment_phase"
    t.string   "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stems", :force => true do |t|
    t.string   "singular"
    t.string   "plural"
    t.string   "vowel"
    t.string   "stress"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
