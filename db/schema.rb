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

ActiveRecord::Schema.define(version: 20151202084015) do

  create_table "codeforces_round_solutions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contest_id"
    t.integer  "round_number",    null: false
    t.integer  "division_number", null: false
    t.string   "level",           null: false
    t.string   "save_path"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "codeforces_round_solutions", ["contest_id"], name: "index_codeforces_round_solutions_on_contest_id"
  add_index "codeforces_round_solutions", ["user_id"], name: "index_codeforces_round_solutions_on_user_id"

  create_table "contests", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "url"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "contests", ["name"], name: "index_contests_on_name", unique: true

  create_table "languages", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "extension",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "top_coder_srm_solutions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contest_id"
    t.integer  "srm_number",      null: false
    t.integer  "division_number", null: false
    t.string   "save_path"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "difficulty",      null: false
  end

  add_index "top_coder_srm_solutions", ["contest_id"], name: "index_top_coder_srm_solutions_on_contest_id"
  add_index "top_coder_srm_solutions", ["user_id"], name: "index_top_coder_srm_solutions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",                          null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "email",                             null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["username"], name: "index_users_on_username"

end
