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

ActiveRecord::Schema.define(version: 20131204131820) do

  create_table "examinations", force: true do |t|
    t.string   "study"
    t.string   "study_instance_uid"
    t.string   "series_instance_uid"
    t.string   "series_description"
    t.string   "sop_instance_uid"
    t.string   "name"
    t.string   "voltage"
    t.string   "current"
    t.string   "exposure"
    t.string   "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end