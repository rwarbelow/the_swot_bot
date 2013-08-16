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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130816013507) do

  create_table "guardian_profiles", :force => true do |t|
    t.string   "address"
    t.string   "email"
    t.string   "preferred_language", :default => "English", :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "guardianships", :force => true do |t|
    t.integer  "student_profile_id"
    t.integer  "guardian_profile_id"
    t.string   "relationship_to_student", :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "phone_numbers", :force => true do |t|
    t.string   "number"
    t.string   "type"
    t.integer  "phone_numberable_id"
    t.string   "phone_numberable_type"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "student_profiles", :force => true do |t|
    t.string   "gender",      :null => false
    t.date     "birthday",    :null => false
    t.string   "address"
    t.string   "ccsd_id",     :null => false
    t.integer  "grade_level", :null => false
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "teacher_profiles", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_identities", :force => true do |t|
    t.string   "username",            :null => false
    t.string   "password_digest",     :null => false
    t.string   "first_name",          :null => false
    t.string   "last_name",           :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "student_profile_id"
    t.integer  "teacher_profile_id"
    t.integer  "guardian_profile_id"
  end

end
