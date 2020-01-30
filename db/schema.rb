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

ActiveRecord::Schema.define(version: 2020_01_29_184627) do

  create_table "parking_lots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "car_park_no"
    t.string "address"
    t.decimal "latitude", precision: 18, scale: 14
    t.decimal "longitude", precision: 18, scale: 14
    t.string "car_park_type"
    t.string "type_of_parking_system"
    t.string "short_term_parking"
    t.string "free_parking"
    t.string "night_parking"
    t.integer "car_park_decks", default: 0
    t.decimal "gantry_height", precision: 3, scale: 2, default: "0.0"
    t.string "car_park_basement"
    t.integer "total_lots", default: 0
    t.integer "lots_available", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_park_no"], name: "index_parking_lots_on_car_park_no"
    t.index ["latitude"], name: "index_parking_lots_on_latitude"
    t.index ["longitude"], name: "index_parking_lots_on_longitude"
    t.index ["lots_available"], name: "index_parking_lots_on_lots_available"
    t.index ["total_lots"], name: "index_parking_lots_on_total_lots"
  end

end
