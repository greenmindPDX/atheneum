# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150625211957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_comments", force: :cascade do |t|
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "application_id"
  end

  create_table "application_transitions", force: :cascade do |t|
    t.string   "to_state",                      null: false
    t.text     "metadata",       default: "{}"
    t.integer  "sort_key",                      null: false
    t.integer  "application_id",                null: false
    t.boolean  "most_recent",                   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "application_transitions", ["application_id", "most_recent"], name: "index_application_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
  add_index "application_transitions", ["application_id", "sort_key"], name: "index_application_transitions_parent_sort", unique: true, using: :btree

  create_table "applications", force: :cascade do |t|
    t.string   "best_film"
    t.text     "community_role"
    t.string   "conversation_starter"
    t.text     "essential_to_writing"
    t.string   "family_hero"
    t.string   "favorite_quiet_meal"
    t.string   "fiction_character"
    t.string   "film_character"
    t.string   "genre"
    t.string   "head_turner"
    t.string   "location_reference"
    t.string   "location_sample"
    t.string   "personality_word"
    t.string   "political_hero"
    t.string   "studied_with"
    t.string   "time_period"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "writing_sample"
    t.string   "recommender"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "application_id"
    t.text     "comment"
    t.integer  "top_comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["application_id"], name: "index_comments_on_application_id", using: :btree
  add_index "comments", ["top_comment_id"], name: "index_comments_on_top_comment_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "role"
  end

  create_table "terms", force: :cascade do |t|
    t.text     "term"
    t.boolean  "active"
    t.integer  "termable_id"
    t.string   "termable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "terms", ["termable_type", "termable_id"], name: "index_terms_on_termable_type_and_termable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "login_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",       default: 3
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "genre"
  end

end
