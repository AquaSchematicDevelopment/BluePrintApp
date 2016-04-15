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

ActiveRecord::Schema.define(version: 20160407005053) do

  create_table "holdings", force: :cascade do |t|
    t.integer  "portfolio_id", limit: 4
    t.integer  "team_id",      limit: 4
    t.integer  "blue_prints",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "holdings", ["portfolio_id"], name: "index_holdings_on_portfolio_id", using: :btree
  add_index "holdings", ["team_id"], name: "index_holdings_on_team_id", using: :btree

  create_table "leagues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "sport_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "leagues", ["sport_id"], name: "index_leagues_on_sport_id", using: :btree

  create_table "portfolios", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "season_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "portfolios", ["season_id"], name: "index_portfolios_on_season_id", using: :btree
  add_index "portfolios", ["user_id"], name: "index_portfolios_on_user_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer  "league_id",  limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sell_requests", force: :cascade do |t|
    t.integer  "portfolio_id", limit: 4
    t.integer  "team_id",      limit: 4
    t.decimal  "price",                  precision: 10
    t.integer  "amount",       limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "sell_requests", ["portfolio_id"], name: "index_sell_requests_on_portfolio_id", using: :btree
  add_index "sell_requests", ["team_id"], name: "index_sell_requests_on_team_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "book_value",             precision: 12, scale: 4
    t.integer  "season_id",  limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "teams", ["season_id"], name: "index_teams_on_season_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "from_portfolio", limit: 4
    t.integer  "to_portfolio",   limit: 4
    t.integer  "team_id",        limit: 4
    t.decimal  "price",                    precision: 10
    t.integer  "amount",         limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "transactions", ["team_id"], name: "index_transactions_on_team_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 255
    t.decimal  "funds",                       precision: 10
    t.string   "role",            limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
