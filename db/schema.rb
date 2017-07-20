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

ActiveRecord::Schema.define(version: 20170719222538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "user_id"
    t.string "street_number"
    t.string "street_name"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "google_place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "callbacks", id: :serial, force: :cascade do |t|
    t.integer "place_id"
    t.date "call_back_date"
    t.boolean "called"
  end

  create_table "carts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts_products", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "product_id"
    t.decimal "amount", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_carts_products_on_cart_id"
    t.index ["product_id"], name: "index_carts_products_on_product_id"
  end

  create_table "notes", id: :serial, force: :cascade do |t|
    t.integer "place_id"
    t.text "note_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "address_id"
    t.integer "stripe_token_id"
    t.integer "subtotal"
    t.integer "shipping"
    t.integer "tax"
    t.integer "total"
    t.date "expected_delivery_date"
    t.datetime "delivered_at"
    t.boolean "paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
  end

  create_table "place_statuses", id: :serial, force: :cascade do |t|
    t.integer "place_id"
    t.integer "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["place_id"], name: "index_place_statuses_on_place_id"
    t.index ["status_id"], name: "index_place_statuses_on_status_id"
  end

  create_table "place_types", id: :serial, force: :cascade do |t|
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", id: :serial, force: :cascade do |t|
    t.decimal "latitude", precision: 15, scale: 10
    t.decimal "longitude", precision: 15, scale: 10
    t.string "google_place_id"
    t.string "name"
    t.decimal "rating", precision: 2, scale: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "phone_number"
    t.string "address"
    t.integer "place_type_id"
    t.index ["google_place_id"], name: "index_places_on_google_place_id", unique: true
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 5, scale: 2
    t.string "image_url"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", id: :serial, force: :cascade do |t|
    t.string "status"
  end

  create_table "stripe_tokens", force: :cascade do |t|
    t.integer "user_id"
    t.integer "last_4"
    t.string "token"
    t.text "response"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stripe_tokens_on_user_id"
  end

end
