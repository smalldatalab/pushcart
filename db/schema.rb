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

ActiveRecord::Schema.define(version: 20150517231341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "household_members", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "age",        limit: 255
    t.string   "gender",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "itemizables", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "purchase_id"
    t.float    "quantity"
    t.float    "total_price"
    t.string   "price_breakdown"
    t.boolean  "discounted",      default: false
    t.string   "color_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "swap_1_id"
    t.integer  "swap_2_id"
    t.integer  "swap_3_id"
    t.integer  "chosen_swap_id"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "description",            limit: 255
    t.string   "category",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "ntx_api_nutrition_data"
    t.json     "ntx_api_metadata"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "raw_html"
    t.text     "raw_text"
    t.text     "to"
    t.text     "from"
    t.text     "subject"
    t.boolean  "successfully_processed", default: false
    t.boolean  "scraped",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "kind"
    t.json     "inbox_metadata"
    t.datetime "date"
    t.text     "source"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "purchases", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "vendor",          limit: 255
    t.string   "sender_email",    limit: 255
    t.string   "order_unique_id", limit: 255
    t.float    "total_price"
    t.text     "raw_message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sub_vendor",      limit: 255
    t.datetime "order_date"
  end

  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree

  create_table "swap_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "swaps", force: :cascade do |t|
    t.integer  "swap_category_id"
    t.string   "name",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color_code"
  end

  add_index "swaps", ["swap_category_id"], name: "index_swaps_on_swap_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                           limit: 255, default: "",   null: false
    t.integer  "sign_in_count",                               default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",              limit: 255
    t.string   "last_sign_in_ip",                 limit: 255
    t.string   "confirmation_token",              limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",               limit: 255
    t.string   "endpoint_email",                  limit: 255, default: "",   null: false
    t.datetime "authentication_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token",            limit: 255
    t.string   "name",                            limit: 255
    t.json     "inbox_api_token"
    t.string   "identity_provider",               limit: 255
    t.datetime "inbox_last_scraped"
    t.boolean  "beta_list",                                   default: true
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["endpoint_email"], name: "index_users_on_endpoint_email", unique: true, using: :btree

end
