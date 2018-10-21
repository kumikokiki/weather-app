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

ActiveRecord::Schema.define(version: 20181020121052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forecasts", force: :cascade do |t|
    t.string   "request_location",     null: false
    t.string   "current_weather_code", null: false
    t.datetime "date_time",            null: false
    t.integer  "current_temperature",  null: false
    t.string   "current_weather_text", null: false
    t.string   "temperature_unit",     null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "forecast_id"
    t.string   "city",        null: false
    t.string   "region"
    t.string   "country"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["forecast_id"], name: "index_locations_on_forecast_id", using: :btree
  end

  create_table "weather", force: :cascade do |t|
    t.integer  "forecast_id"
    t.string   "weather_code",     null: false
    t.datetime "date",             null: false
    t.integer  "high_temperature", null: false
    t.integer  "low_temperature",  null: false
    t.string   "weather_text",     null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["forecast_id"], name: "index_weather_on_forecast_id", using: :btree
  end

end
