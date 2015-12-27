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

ActiveRecord::Schema.define(version: 20151227215140) do

  create_table "codeforces_round_solutions", force: :cascade do |t|
    t.integer  "user_id",                               null: false
    t.integer  "contest_id",                            null: false
    t.integer  "round_number",                          null: false
    t.integer  "division_number",                       null: false
    t.string   "level",                                 null: false
    t.string   "save_path"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "language_id",                           null: false
    t.string   "original_link"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "codeforces_round_solutions", ["cached_votes_down"], name: "index_codeforces_round_solutions_on_cached_votes_down"
  add_index "codeforces_round_solutions", ["cached_votes_score"], name: "index_codeforces_round_solutions_on_cached_votes_score"
  add_index "codeforces_round_solutions", ["cached_votes_total"], name: "index_codeforces_round_solutions_on_cached_votes_total"
  add_index "codeforces_round_solutions", ["cached_votes_up"], name: "index_codeforces_round_solutions_on_cached_votes_up"
  add_index "codeforces_round_solutions", ["cached_weighted_average"], name: "index_codeforces_round_solutions_on_cached_weighted_average"
  add_index "codeforces_round_solutions", ["cached_weighted_score"], name: "index_codeforces_round_solutions_on_cached_weighted_score"
  add_index "codeforces_round_solutions", ["cached_weighted_total"], name: "index_codeforces_round_solutions_on_cached_weighted_total"
  add_index "codeforces_round_solutions", ["contest_id"], name: "index_codeforces_round_solutions_on_contest_id"
  add_index "codeforces_round_solutions", ["language_id"], name: "index_codeforces_round_solutions_on_language_id"
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
    t.string   "ace_mode",   null: false
  end

  create_table "top_coder_srm_solutions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contest_id"
    t.integer  "srm_number",                            null: false
    t.integer  "division_number",                       null: false
    t.string   "save_path"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "difficulty",                            null: false
    t.integer  "language_id"
    t.string   "original_link"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "top_coder_srm_solutions", ["cached_votes_down"], name: "index_top_coder_srm_solutions_on_cached_votes_down"
  add_index "top_coder_srm_solutions", ["cached_votes_score"], name: "index_top_coder_srm_solutions_on_cached_votes_score"
  add_index "top_coder_srm_solutions", ["cached_votes_total"], name: "index_top_coder_srm_solutions_on_cached_votes_total"
  add_index "top_coder_srm_solutions", ["cached_votes_up"], name: "index_top_coder_srm_solutions_on_cached_votes_up"
  add_index "top_coder_srm_solutions", ["cached_weighted_average"], name: "index_top_coder_srm_solutions_on_cached_weighted_average"
  add_index "top_coder_srm_solutions", ["cached_weighted_score"], name: "index_top_coder_srm_solutions_on_cached_weighted_score"
  add_index "top_coder_srm_solutions", ["cached_weighted_total"], name: "index_top_coder_srm_solutions_on_cached_weighted_total"
  add_index "top_coder_srm_solutions", ["contest_id"], name: "index_top_coder_srm_solutions_on_contest_id"
  add_index "top_coder_srm_solutions", ["language_id"], name: "index_top_coder_srm_solutions_on_language_id"
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

  create_table "uva_solutions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contest_id"
    t.integer  "language_id"
    t.integer  "problem_number",                        null: false
    t.string   "save_path"
    t.string   "original_link"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.string   "title"
  end

  add_index "uva_solutions", ["cached_votes_down"], name: "index_uva_solutions_on_cached_votes_down"
  add_index "uva_solutions", ["cached_votes_score"], name: "index_uva_solutions_on_cached_votes_score"
  add_index "uva_solutions", ["cached_votes_total"], name: "index_uva_solutions_on_cached_votes_total"
  add_index "uva_solutions", ["cached_votes_up"], name: "index_uva_solutions_on_cached_votes_up"
  add_index "uva_solutions", ["cached_weighted_average"], name: "index_uva_solutions_on_cached_weighted_average"
  add_index "uva_solutions", ["cached_weighted_score"], name: "index_uva_solutions_on_cached_weighted_score"
  add_index "uva_solutions", ["cached_weighted_total"], name: "index_uva_solutions_on_cached_weighted_total"
  add_index "uva_solutions", ["contest_id"], name: "index_uva_solutions_on_contest_id"
  add_index "uva_solutions", ["language_id"], name: "index_uva_solutions_on_language_id"
  add_index "uva_solutions", ["user_id"], name: "index_uva_solutions_on_user_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
