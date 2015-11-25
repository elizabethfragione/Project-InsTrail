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

ActiveRecord::Schema.define(version: 20151123225822) do

  create_table "maps", force: :cascade do |t|
    t.boolean  "authenticated", null: false
    t.string   "kind"
    t.string   "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "trail_id"
    t.string   "trail_name"
    t.string   "low_resolution_url"
    t.string   "thumbnail_url"
    t.string   "standard_resolution_url"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "photos", ["trail_id"], name: "index_photos_on_trail_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "settings", force: :cascade do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trails", force: :cascade do |t|
    t.integer  "map_id"
    t.string   "name",       null: false
    t.boolean  "user"
    t.float    "lat"
    t.float    "lon"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trails", ["map_id"], name: "index_trails_on_map_id"
  add_index "trails", ["name"], name: "index_trails_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "nickname"
    t.string   "image_url"
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  add_index "users", ["provider"], name: "index_users_on_provider"
  add_index "users", ["uid"], name: "index_users_on_uid"

end
