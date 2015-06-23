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

ActiveRecord::Schema.define(version: 20150623195321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "beacons", force: :cascade do |t|
    t.string   "name"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "uuid",        array: true
  end

  add_index "beacons", ["property_id"], name: "index_beacons_on_property_id", using: :btree

  create_table "fields", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "highlights", force: :cascade do |t|
    t.string   "name"
    t.string   "sub_heading"
    t.binary   "image"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "highlights", ["property_id"], name: "index_highlights_on_property_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "name"
    t.binary   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.decimal  "lat",         precision: 9, scale: 6
    t.decimal  "lng",         precision: 9, scale: 6
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
    t.string   "image_url"
    t.string   "location"
  end

  add_index "properties", ["user_id"], name: "index_properties_on_user_id", using: :btree

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "user_devices", force: :cascade do |t|
    t.string   "name"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_devices", ["user_id"], name: "index_user_devices_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
