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

ActiveRecord::Schema.define(version: 20141219200126) do

  create_table "auctions", id: false, force: true do |t|
    t.string   "auction_id",    limit: 20,  null: false
    t.string   "auction_name",  limit: 200, null: false
    t.decimal  "price"
    t.integer  "tax_rate",      limit: 2
    t.string   "seller_id",     limit: 50
    t.datetime "end_time"
    t.string   "url",           limit: 200
    t.integer  "sold_flg",      limit: 1
    t.integer  "is_custom",     limit: 1
    t.string   "category_id",   limit: 4
    t.string   "brand_id",      limit: 4
    t.string   "modu_id",       limit: 7
    t.string   "paymethod_id",  limit: 4
    t.decimal  "payment_cost"
    t.integer  "ship_type",     limit: 1
    t.string   "shipmethod_id", limit: 4
    t.decimal  "shipment_cost"
    t.string   "shipment_code", limit: 12
    t.string   "memo",          limit: 200
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "auctions", ["auction_id"], name: "index_auctions_on_auction_id", unique: true
  add_index "auctions", ["brand_id"], name: "index_auctions_on_brand_id"
  add_index "auctions", ["category_id"], name: "index_auctions_on_category_id"
  add_index "auctions", ["modu_id"], name: "index_auctions_on_modu_id"

  create_table "brands", id: false, force: true do |t|
    t.string   "brand_id",   limit: 4,   null: false
    t.string   "brand_name", limit: 100, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "brands", ["brand_id"], name: "index_brands_on_brand_id", unique: true

  create_table "categories", id: false, force: true do |t|
    t.string   "category_id",   limit: 4,   null: false
    t.string   "category_name", limit: 100, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", unique: true

  create_table "customs", id: false, force: true do |t|
    t.string   "custom_id",   limit: 20,  null: false
    t.string   "custom_name", limit: 200, null: false
    t.integer  "is_auction",  limit: 1
    t.integer  "percentage",  limit: 3
    t.string   "auction_id",  limit: 20
    t.decimal  "net_cost"
    t.decimal  "tax_cost"
    t.decimal  "other_cost"
    t.string   "memo",        limit: 200
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "customs", ["auction_id"], name: "index_customs_on_auction_id"
  add_index "customs", ["custom_id"], name: "index_customs_on_custom_id", unique: true

  create_table "modus", id: false, force: true do |t|
    t.string   "modu_id",    limit: 7,   null: false
    t.string   "modu_name",  limit: 100, null: false
    t.string   "brand_id",   limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "modus", ["brand_id"], name: "index_modus_on_brand_id"
  add_index "modus", ["modu_id"], name: "index_modus_on_modu_id", unique: true

  create_table "paymethods", id: false, force: true do |t|
    t.string   "paymethod_id",   limit: 4,   null: false
    t.string   "paymethod_name", limit: 100, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "paymethods", ["paymethod_id"], name: "index_paymethods_on_paymethod_id", unique: true

  create_table "shipmethods", id: false, force: true do |t|
    t.string   "shipmethod_id",   limit: 4,   null: false
    t.integer  "ship_type",       limit: 1,   null: false
    t.string   "shipmethod_name", limit: 100, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "shipmethods", ["shipmethod_id"], name: "index_shipmethods_on_shipmethod_id", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
