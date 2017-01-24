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

ActiveRecord::Schema.define(version: 20170123172111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyses", force: :cascade do |t|
    t.string   "uid"
    t.integer  "api_client_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "analyses", ["api_client_id"], name: "index_analyses_on_api_client_id", using: :btree
  add_index "analyses", ["uid"], name: "index_analyses_on_uid", using: :btree

  create_table "analyses_contents", id: false, force: :cascade do |t|
    t.integer "analysis_id"
    t.integer "content_id"
  end

  add_index "analyses_contents", ["analysis_id"], name: "index_analyses_contents_on_analysis_id", using: :btree
  add_index "analyses_contents", ["content_id"], name: "index_analyses_contents_on_content_id", using: :btree

  create_table "api_clients", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "expires_at"
    t.integer  "safe_count"
    t.integer  "unsafe_count"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "api_clients", ["access_token"], name: "index_api_clients_on_access_token", using: :btree

  create_table "api_clients_urls", id: false, force: :cascade do |t|
    t.integer "api_client_id"
    t.integer "url_id"
  end

  add_index "api_clients_urls", ["api_client_id"], name: "index_api_clients_urls_on_api_client_id", using: :btree
  add_index "api_clients_urls", ["url_id"], name: "index_api_clients_urls_on_url_id", using: :btree

  create_table "contents", force: :cascade do |t|
    t.string   "type"
    t.text     "code_md5"
    t.boolean  "safe?"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "original_length"
  end

  add_index "contents", ["code_md5", "original_length", "type"], name: "index_contents_on_code_md5_and_original_length_and_type", unique: true, using: :btree

  create_table "metrics", force: :cascade do |t|
    t.integer  "api_client_id"
    t.string   "browser"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "metrics", ["api_client_id"], name: "index_metrics_on_api_client_id", using: :btree

  create_table "temp_contents", force: :cascade do |t|
    t.text     "code"
    t.string   "code_md5"
    t.integer  "original_length"
    t.string   "content_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "urls", force: :cascade do |t|
    t.string   "url"
    t.boolean  "safe?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "analyses", "api_clients"
  add_foreign_key "metrics", "api_clients"
end
