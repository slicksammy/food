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

ActiveRecord::Schema.define(version: 20170801200847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "user_uuid"
    t.string "street_number"
    t.string "street_name"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "google_place_id"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_uuid"], name: "index_addresses_on_user_uuid"
    t.index ["uuid"], name: "index_addresses_on_uuid"
  end

  create_table "callbacks", id: :serial, force: :cascade do |t|
    t.integer "place_id"
    t.date "call_back_date"
    t.boolean "called"
  end

  create_table "carts", force: :cascade do |t|
    t.string "user_uuid"
    t.string "status"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_uuid"], name: "index_carts_on_user_uuid"
    t.index ["uuid"], name: "index_carts_on_uuid"
  end

  create_table "carts_products", force: :cascade do |t|
    t.string "cart_uuid"
    t.string "product_uuid"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_uuid"], name: "index_carts_products_on_cart_uuid"
    t.index ["product_uuid"], name: "index_carts_products_on_product_uuid"
  end

  create_table "notes", id: :serial, force: :cascade do |t|
    t.integer "place_id"
    t.text "note_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string "cart_uuid"
    t.string "address_uuid"
    t.string "stripe_token_uuid"
    t.integer "subtotal_cents"
    t.integer "shipping_cents"
    t.integer "tax_cents"
    t.integer "total_cents"
    t.date "expected_delivery_date"
    t.datetime "delivered_at"
    t.boolean "paid"
    t.string "status"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_uuid"], name: "index_orders_on_cart_uuid"
    t.index ["uuid"], name: "index_orders_on_uuid"
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

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "description"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents"
    t.index ["uuid"], name: "index_products_on_uuid"
  end

  create_table "statuses", id: :serial, force: :cascade do |t|
    t.string "status"
  end

  create_table "stripe_charges", force: :cascade do |t|
    t.string "order_uuid"
    t.integer "amount_cents"
    t.string "stripe_token_uuid"
    t.string "status"
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_uuid"], name: "index_stripe_charges_on_order_uuid"
    t.index ["stripe_token_uuid"], name: "index_stripe_charges_on_stripe_token_uuid"
  end

  create_table "stripe_tokens", force: :cascade do |t|
    t.string "user_uuid"
    t.string "last_4"
    t.string "token"
    t.text "response"
    t.boolean "active"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_uuid"], name: "index_stripe_tokens_on_user_uuid"
    t.index ["uuid"], name: "index_stripe_tokens_on_uuid"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "salt"
    t.string "encrypted_password"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

end
