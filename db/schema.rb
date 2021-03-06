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

ActiveRecord::Schema.define(version: 20160228044149) do

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
    t.index ["cached_votes_down"], name: "index_codeforces_round_solutions_on_cached_votes_down"
    t.index ["cached_votes_score"], name: "index_codeforces_round_solutions_on_cached_votes_score"
    t.index ["cached_votes_total"], name: "index_codeforces_round_solutions_on_cached_votes_total"
    t.index ["cached_votes_up"], name: "index_codeforces_round_solutions_on_cached_votes_up"
    t.index ["cached_weighted_average"], name: "index_codeforces_round_solutions_on_cached_weighted_average"
    t.index ["cached_weighted_score"], name: "index_codeforces_round_solutions_on_cached_weighted_score"
    t.index ["cached_weighted_total"], name: "index_codeforces_round_solutions_on_cached_weighted_total"
    t.index ["contest_id"], name: "index_codeforces_round_solutions_on_contest_id"
    t.index ["language_id"], name: "index_codeforces_round_solutions_on_language_id"
    t.index ["user_id"], name: "index_codeforces_round_solutions_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contests", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "url"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_contests_on_name", unique: true
  end

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
    t.index ["cached_votes_down"], name: "index_top_coder_srm_solutions_on_cached_votes_down"
    t.index ["cached_votes_score"], name: "index_top_coder_srm_solutions_on_cached_votes_score"
    t.index ["cached_votes_total"], name: "index_top_coder_srm_solutions_on_cached_votes_total"
    t.index ["cached_votes_up"], name: "index_top_coder_srm_solutions_on_cached_votes_up"
    t.index ["cached_weighted_average"], name: "index_top_coder_srm_solutions_on_cached_weighted_average"
    t.index ["cached_weighted_score"], name: "index_top_coder_srm_solutions_on_cached_weighted_score"
    t.index ["cached_weighted_total"], name: "index_top_coder_srm_solutions_on_cached_weighted_total"
    t.index ["contest_id"], name: "index_top_coder_srm_solutions_on_contest_id"
    t.index ["language_id"], name: "index_top_coder_srm_solutions_on_language_id"
    t.index ["user_id"], name: "index_top_coder_srm_solutions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                                         null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "email",                                            null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",                            default: false
    t.string   "activation_digest"
    t.boolean  "activated",                        default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "codeforces_handle"
    t.string   "topcoder_handle"
    t.string   "uva_handle"
    t.integer  "codeforces_round_solutions_count", default: 0
    t.integer  "top_coder_srm_solutions_count",    default: 0
    t.integer  "uva_solutions_count",              default: 0
    t.integer  "solutions_count",                  default: 0
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

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
    t.index ["cached_votes_down"], name: "index_uva_solutions_on_cached_votes_down"
    t.index ["cached_votes_score"], name: "index_uva_solutions_on_cached_votes_score"
    t.index ["cached_votes_total"], name: "index_uva_solutions_on_cached_votes_total"
    t.index ["cached_votes_up"], name: "index_uva_solutions_on_cached_votes_up"
    t.index ["cached_weighted_average"], name: "index_uva_solutions_on_cached_weighted_average"
    t.index ["cached_weighted_score"], name: "index_uva_solutions_on_cached_weighted_score"
    t.index ["cached_weighted_total"], name: "index_uva_solutions_on_cached_weighted_total"
    t.index ["contest_id"], name: "index_uva_solutions_on_contest_id"
    t.index ["language_id"], name: "index_uva_solutions_on_language_id"
    t.index ["user_id"], name: "index_uva_solutions_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

end
