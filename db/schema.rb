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

ActiveRecord::Schema.define(version: 20140901153428) do

  create_table "blogs", force: true do |t|
    t.string   "urlname",                      null: false
    t.string   "gh_login",                     null: false
    t.string   "gh_repo_name",                 null: false
    t.string   "title",                        null: false
    t.boolean  "first_pushed", default: false, null: false
    t.string   "hook_key",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogs", ["gh_login", "gh_repo_name"], name: "index_blogs_on_gh_login_and_gh_repo_name", unique: true, using: :btree
  add_index "blogs", ["hook_key"], name: "index_blogs_on_hook_key", unique: true, using: :btree
  add_index "blogs", ["urlname"], name: "index_blogs_on_urlname", unique: true, using: :btree

  create_table "ownerships", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "blog_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ownerships", ["blog_id"], name: "ownerships_blog_id_fk", using: :btree
  add_index "ownerships", ["user_id", "blog_id"], name: "index_ownerships_on_user_id_and_blog_id", unique: true, using: :btree

  create_table "profiles", force: true do |t|
    t.integer  "user_id",                  null: false
    t.string   "name",        default: "", null: false
    t.string   "avatar_url",               null: false
    t.string   "description", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "providers", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.string   "gh_login"
    t.string   "uid",        null: false
    t.string   "token",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["gh_login"], name: "index_providers_on_gh_login", unique: true, using: :btree
  add_index "providers", ["name", "uid"], name: "index_providers_on_name_and_uid", unique: true, using: :btree
  add_index "providers", ["user_id", "name"], name: "index_providers_on_user_id_and_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                         null: false
    t.string   "email",                            null: false
    t.integer  "sign_in_count",        default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "ownerships", "blogs", name: "ownerships_blog_id_fk", dependent: :delete
  add_foreign_key "ownerships", "users", name: "ownerships_user_id_fk", dependent: :delete

  add_foreign_key "profiles", "users", name: "profiles_user_id_fk", dependent: :delete

  add_foreign_key "providers", "users", name: "providers_user_id_fk", dependent: :delete

end
