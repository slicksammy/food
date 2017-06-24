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

ActiveRecord::Schema.define(version: 20170622185252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "callbacks", force: :cascade do |t|
    t.integer "place_id"
    t.date    "call_back_date"
    t.boolean "called"
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "place_id"
    t.text     "note_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "place_statuses", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "place_statuses", ["place_id"], name: "index_place_statuses_on_place_id", using: :btree
  add_index "place_statuses", ["status_id"], name: "index_place_statuses_on_status_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.decimal  "latitude",        precision: 15, scale: 10
    t.decimal  "longitude",       precision: 15, scale: 10
    t.string   "google_place_id"
    t.string   "name"
    t.string   "internal_type"
    t.decimal  "rating",          precision: 2,  scale: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "address"
  end

  add_index "places", ["google_place_id"], name: "index_places_on_google_place_id", unique: true, using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string "status"
  end

end
