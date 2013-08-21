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

ActiveRecord::Schema.define(:version => 20130821175235) do

  create_table "announcements", :force => true do |t|
    t.integer  "teacher_id"
    t.string   "title"
    t.text     "body"
    t.date     "expiration_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "assignments", :force => true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.date     "due_date",                        :null => false
    t.integer  "maximum_points", :default => 100, :null => false
  end

  create_table "courses", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.integer  "period"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guardians", :force => true do |t|
    t.string   "address"
    t.string   "email"
    t.string   "preferred_language", :default => "English", :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "guardianships", :force => true do |t|
    t.integer  "student_id"
    t.integer  "guardian_id"
    t.string   "relationship_to_student", :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "password_digest", :null => false
    t.string   "first_name",      :null => false
    t.string   "last_name",       :null => false
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "guardian_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "inspirations", :force => true do |t|
    t.string   "body"
    t.string   "source"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.integer  "target_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "subject"
  end

  create_table "phone_numbers", :force => true do |t|
    t.string   "number"
    t.string   "kind"
    t.integer  "phone_numberable_id"
    t.string   "phone_numberable_type"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "readings", :force => true do |t|
    t.integer  "message_id"
    t.datetime "created_at"
  end

  create_table "student_action_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "allow_multiple_entries_per_date"
  end

  create_table "student_action_types", :force => true do |t|
    t.integer  "student_action_category_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "student_actions", :force => true do |t|
    t.integer  "enrollment_id"
    t.integer  "student_action_type_id"
    t.string   "comment"
    t.date     "date",                   :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "gender",            :null => false
    t.date     "birthday",          :null => false
    t.string   "address"
    t.string   "ccsd_id",           :null => false
    t.integer  "grade_level",       :null => false
    t.string   "email"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "registration_code"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "submissions", :force => true do |t|
    t.integer  "student_id",                   :null => false
    t.integer  "assignment_id",                :null => false
    t.integer  "points_earned", :default => 0, :null => false
    t.datetime "created_at"
  end

  create_table "teachers", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
