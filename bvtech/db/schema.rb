# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_19_121752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.date "due_date", null: false
    t.bigint "sport_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_events_on_name", unique: true
    t.index ["sport_id"], name: "index_events_on_sport_id"
  end

  create_table "markets", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "sport_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_markets_on_name", unique: true
    t.index ["sport_id"], name: "index_markets_on_sport_id"
  end

  create_table "sports", force: :cascade do |t|
    t.integer "external_id", null: false
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_id"], name: "index_sports_on_external_id", unique: true
    t.index ["name", "external_id"], name: "index_sports_on_name_and_external_id", unique: true
  end

  add_foreign_key "events", "sports"
  add_foreign_key "markets", "sports"
end
