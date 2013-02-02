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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130202224004) do

  create_table "contracts", :force => true do |t|
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.integer  "location_id"
    t.date     "begin"
    t.date     "end"
    t.integer  "rate"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "contracts", ["buyer_id"], :name => "index_contracts_on_buyer_id"
  add_index "contracts", ["location_id"], :name => "index_contracts_on_location_id"
  add_index "contracts", ["seller_id"], :name => "index_contracts_on_seller_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.decimal  "rate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "password"
    t.integer  "zipcode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
