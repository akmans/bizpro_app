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

ActiveRecord::Schema.define(version: 20151011124929) do

  create_table "auctions", id: false, force: true do |t|
    t.string   "auction_id",    limit: 20,  null: false
    t.string   "auction_name",  limit: 200, null: false
    t.decimal  "price"
    t.integer  "tax_rate",      limit: 2
    t.string   "seller_id",     limit: 50
    t.datetime "end_time"
    t.string   "url",           limit: 200
    t.integer  "sold_flg",      limit: 1
    t.integer  "ope_flg",       limit: 1
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
    t.integer  "manual"
  end

  add_index "auctions", ["auction_id"], name: "index_auctions_on_auction_id", unique: true
  add_index "auctions", ["auction_name"], name: "index_auctions_on_auction_name"
  add_index "auctions", ["brand_id"], name: "index_auctions_on_brand_id"
  add_index "auctions", ["category_id"], name: "index_auctions_on_category_id"
  add_index "auctions", ["modu_id"], name: "index_auctions_on_modu_id"
  add_index "auctions", ["paymethod_id"], name: "index_auctions_on_paymethod_id"
  add_index "auctions", ["shipmethod_id"], name: "index_auctions_on_shipmethod_id"

  create_table "brands", id: false, force: true do |t|
    t.string   "brand_id",   limit: 4,   null: false
    t.string   "brand_name", limit: 100, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "brands", ["brand_id"], name: "index_brands_on_brand_id", unique: true

  create_table "cashes", id: false, force: true do |t|
    t.string   "cash_id",       limit: 20,  null: false
    t.string   "remark",        limit: 200, null: false
    t.integer  "is_domestic",   limit: 1
    t.integer  "is_in",         limit: 1
    t.decimal  "exchange_rate"
    t.string   "memo",          limit: 200
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.date     "regist_date"
    t.decimal  "amount"
  end

  add_index "cashes", ["cash_id"], name: "index_cashes_on_cash_id", unique: true
  add_index "cashes", ["remark"], name: "index_cashes_on_remark"

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
    t.date     "regist_date"
    t.integer  "cancel_flg",  limit: 1
  end

  add_index "customs", ["auction_id"], name: "index_customs_on_auction_id"
  add_index "customs", ["custom_id"], name: "index_customs_on_custom_id", unique: true
  add_index "customs", ["custom_name"], name: "index_customs_on_custom_name"

  create_table "modus", id: false, force: true do |t|
    t.string   "modu_id",    limit: 7,   null: false
    t.string   "modu_name",  limit: 100, null: false
    t.string   "brand_id",   limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "modus", ["brand_id"], name: "index_modus_on_brand_id"
  add_index "modus", ["modu_id"], name: "index_modus_on_modu_id", unique: true

  create_table "pa_maps", id: false, force: true do |t|
    t.string   "auction_id", limit: 20, null: false
    t.string   "product_id", limit: 20, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "pa_maps", ["auction_id"], name: "index_pa_maps_on_auction_id", unique: true
  add_index "pa_maps", ["product_id"], name: "index_pa_maps_on_product_id"

  create_table "paymethods", id: false, force: true do |t|
    t.string   "paymethod_id",   limit: 4,   null: false
    t.string   "paymethod_name", limit: 100, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "paymethods", ["paymethod_id"], name: "index_paymethods_on_paymethod_id", unique: true

  create_table "pc_maps", id: false, force: true do |t|
    t.string   "custom_id",  limit: 20, null: false
    t.string   "product_id", limit: 20, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "pc_maps", ["custom_id"], name: "index_pc_maps_on_custom_id", unique: true
  add_index "pc_maps", ["product_id"], name: "index_pc_maps_on_product_id"

  create_table "products", id: false, force: true do |t|
    t.string   "product_id",    limit: 20,  null: false
    t.string   "product_name",  limit: 200, null: false
    t.integer  "is_domestic",   limit: 1
    t.decimal  "exchange_rate"
    t.string   "category_id",   limit: 4
    t.string   "brand_id",      limit: 4
    t.string   "modu_id",       limit: 7
    t.string   "memo",          limit: 200
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.date     "sold_date"
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id"
  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["modu_id"], name: "index_products_on_modu_id"
  add_index "products", ["product_id"], name: "index_products_on_product_id", unique: true
  add_index "products", ["product_name"], name: "index_products_on_product_name"

  create_table "shipment_details", force: true do |t|
    t.string   "shipment_id",  limit: 20, null: false
    t.string   "product_id",   limit: 20, null: false
    t.decimal  "ship_cost"
    t.decimal  "insured_cost"
    t.decimal  "custom_cost"
    t.string   "memo"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "shipment_details", ["product_id"], name: "index_shipment_details_on_product_id"
  add_index "shipment_details", ["shipment_id"], name: "index_shipment_details_on_shipment_id"

  create_table "shipments", id: false, force: true do |t|
    t.string   "shipment_id",   limit: 20,  null: false
    t.string   "shipmethod_id", limit: 4
    t.date     "sent_date"
    t.date     "arrived_date"
    t.string   "memo",          limit: 200
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "shipments", ["shipment_id"], name: "index_shipments_on_shipment_id", unique: true
  add_index "shipments", ["shipmethod_id"], name: "index_shipments_on_shipmethod_id"

  create_table "shipmethods", id: false, force: true do |t|
    t.string   "shipmethod_id",   limit: 4,   null: false
    t.integer  "shipmethod_type", limit: 1,   null: false
    t.string   "shipmethod_name", limit: 100, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "shipmethods", ["shipmethod_id"], name: "index_shipmethods_on_shipmethod_id", unique: true

  create_table "solds", force: true do |t|
    t.string   "product_id",   limit: 20,  null: false
    t.decimal  "sold_price",               null: false
    t.decimal  "ship_charge"
    t.decimal  "other_charge"
    t.date     "sold_date"
    t.string   "memo",         limit: 200
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "solds", ["product_id"], name: "index_solds_on_product_id"

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
