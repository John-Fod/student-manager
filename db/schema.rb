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

ActiveRecord::Schema.define(version: 20150107043901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_sessions", force: true do |t|
    t.integer  "room_id"
    t.integer  "teacher_id"
    t.integer  "school_id"
    t.string   "name"
    t.text     "summary"
    t.datetime "held_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "day"
    t.integer  "period_id"
    t.boolean  "quick_creation", default: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "status",         default: 0
  end

  create_table "class_sessions_students", id: false, force: true do |t|
    t.integer "class_session_id", null: false
    t.integer "student_id",       null: false
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "summary"
    t.integer  "school_id"
    t.integer  "founding_teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_schools", id: false, force: true do |t|
    t.integer "course_id", null: false
    t.integer "school_id", null: false
  end

  create_table "periods", force: true do |t|
    t.integer  "school_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.text     "summary"
    t.integer  "school_id"
    t.integer  "founding_teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "regular_day"
    t.integer  "regular_period_id"
    t.integer  "regular_teacher_id"
  end

  create_table "rooms_students", id: false, force: true do |t|
    t.integer "room_id",    null: false
    t.integer "student_id", null: false
  end

  create_table "rooms_teachers", id: false, force: true do |t|
    t.integer "room_id",    null: false
    t.integer "teacher_id", null: false
  end

  create_table "schools", force: true do |t|
    t.integer  "headmaster_id"
    t.string   "name"
    t.string   "summary"
    t.integer  "student_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools_students", id: false, force: true do |t|
    t.integer "school_id",  null: false
    t.integer "student_id", null: false
  end

  create_table "schools_teachers", id: false, force: true do |t|
    t.integer "school_id",  null: false
    t.integer "teacher_id", null: false
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.text     "about"
    t.text     "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  create_table "teachers", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

end
