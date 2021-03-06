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

ActiveRecord::Schema.define(version: 20140618005126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "routes", force: true do |t|
    t.string  "number"
    t.integer "stop_count"
    t.float   "total_alightings"
    t.float   "total_boardings"
  end

  create_table "routes_stops", id: false, force: true do |t|
    t.integer "route_id", null: false
    t.integer "stop_id",  null: false
  end

  create_table "stops", force: true do |t|
    t.integer "stop_id"
    t.string  "street_on"
    t.string  "street_cross"
    t.float   "boardings"
    t.float   "alightings"
    t.float   "lat"
    t.float   "long"
    t.integer "route_count"
    t.string  "route_list"
  end

end
