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

ActiveRecord::Schema.define(version: 20140501154452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "inbound_emails", force: true do |t|
    t.integer  "user_id"
    t.text     "raw_html"
    t.text     "raw_text"
    t.string   "to"
    t.string   "from"
    t.string   "subject"
    t.boolean  "successfully_processed", default: false
    t.boolean  "scraped",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inbound_emails", ["user_id"], name: "index_inbound_emails_on_user_id", using: :btree

  create_table "items", force: true do |t|
    t.integer  "purchase_id"
    t.string   "name"
    t.string   "description"
    t.string   "price_breakdown"
    t.string   "category"
    t.float    "total_price"
    t.float    "quantity"
    t.boolean  "discounted",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "ntx_api_nutrition_data"
    t.json     "ntx_api_metadata"
  end

  add_index "items", ["purchase_id"], name: "index_items_on_purchase_id", using: :btree

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",                         null: false
    t.string   "uid",                          null: false
    t.string   "secret",                       null: false
    t.boolean  "whitelisted",  default: false
    t.text     "redirect_uri",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "purchases", force: true do |t|
    t.integer  "user_id"
    t.string   "vendor"
    t.string   "sender_email"
    t.string   "order_unique_id"
    t.float    "total_price"
    t.text     "raw_message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ntx_api_rejected_item_count"
    t.integer  "category_rejected_item_count"
  end

  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "endpoint_email",         default: "", null: false
    t.string   "login_token",            default: "", null: false
    t.datetime "login_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_size"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["endpoint_email"], name: "index_users_on_endpoint_email", unique: true, using: :btree
  add_index "users", ["login_token"], name: "index_users_on_login_token", unique: true, using: :btree

end
