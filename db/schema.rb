# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_04_165626) do

  create_table "slugs", force: :cascade do |t|
    t.string "label"
    t.integer "unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.string "race"
    t.integer "size", default: 0
    t.boolean "flying", default: false
    t.integer "hitpoints"
    t.integer "armor", default: 0
    t.integer "shields", default: 0
    t.integer "g_damage"
    t.integer "g_cooldown"
    t.integer "g_attacks", default: 1
    t.integer "g_bonus", default: 1
    t.integer "g_type", default: 0
    t.integer "a_damage"
    t.integer "a_cooldown"
    t.integer "a_attacks", default: 1
    t.integer "a_bonus", default: 1
    t.integer "a_type", default: 0
  end

end
