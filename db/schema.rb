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

ActiveRecord::Schema.define(:version => 20140330224929) do

  create_table "admins", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "announcements", :force => true do |t|
    t.integer  "teacher_id"
    t.string   "title"
    t.text     "body"
    t.date     "expiration_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "announcements", ["teacher_id"], :name => "index_announcements_on_teacher_id"

  create_table "assignment_categories", :force => true do |t|
    t.string   "name"
    t.float    "weight"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "assignment_categories", ["course_id"], :name => "index_assignment_categories_on_course_id"

  create_table "assignments", :force => true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.date     "due_date",                                  :null => false
    t.integer  "maximum_points",         :default => 100,   :null => false
    t.integer  "assignment_category_id"
    t.boolean  "archived",               :default => false
    t.string   "term"
    t.integer  "term_id"
  end

  add_index "assignments", ["archived"], :name => "index_assignments_on_archived"
  add_index "assignments", ["assignment_category_id"], :name => "index_assignments_on_assignment_category_id"
  add_index "assignments", ["course_id"], :name => "index_assignments_on_course_id"
  add_index "assignments", ["due_date"], :name => "index_assignments_on_due_date"
  add_index "assignments", ["term"], :name => "index_assignments_on_term"
  add_index "assignments", ["term_id"], :name => "index_assignments_on_term_id"

  create_table "attendances", :force => true do |t|
    t.integer  "enrollment_id"
    t.integer  "status_id"
    t.date     "date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "attendances", ["enrollment_id"], :name => "index_attendances_on_enrollment_id"
  add_index "attendances", ["status_id"], :name => "index_attendances_on_status_id"

  create_table "courses", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.integer  "period"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "courses", ["subject_id"], :name => "index_courses_on_subject_id"
  add_index "courses", ["teacher_id", "subject_id"], :name => "index_courses_on_teacher_id_and_subject_id"

  create_table "deposits", :force => true do |t|
    t.integer  "student_id"
    t.integer  "amount"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "comments"
    t.integer  "student_balance"
  end

  add_index "deposits", ["amount"], :name => "index_deposits_on_amount"
  add_index "deposits", ["student_id"], :name => "index_deposits_on_student_id"

  create_table "enrollments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.float    "current_grade", :default => 1.0
  end

  add_index "enrollments", ["course_id"], :name => "index_enrollments_on_course_id"
  add_index "enrollments", ["student_id", "course_id"], :name => "index_enrollments_on_student_id_and_course_id"

  create_table "goals", :force => true do |t|
    t.integer  "student_id"
    t.string   "goal"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "goals", ["student_id"], :name => "index_goals_on_student_id"

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

  add_index "guardianships", ["guardian_id"], :name => "index_guardianships_on_guardian_id"
  add_index "guardianships", ["student_id", "guardian_id"], :name => "index_guardianships_on_student_id_and_guardian_id"

  create_table "identities", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "password_digest",                 :null => false
    t.string   "first_name",                      :null => false
    t.string   "last_name",                       :null => false
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "guardian_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "admin_id"
    t.integer  "login_counter",    :default => 0
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_index "identities", ["admin_id"], :name => "index_identities_on_admin_id"
  add_index "identities", ["first_name"], :name => "index_identities_on_first_name"
  add_index "identities", ["guardian_id"], :name => "index_identities_on_guardian_id"
  add_index "identities", ["last_name"], :name => "index_identities_on_last_name"
  add_index "identities", ["student_id"], :name => "index_identities_on_student_id"
  add_index "identities", ["teacher_id"], :name => "index_identities_on_teacher_id"

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
    t.integer  "thread_id"
  end

  add_index "messages", ["author_id", "target_id"], :name => "index_messages_on_author_id_and_target_id"
  add_index "messages", ["target_id"], :name => "index_messages_on_target_id"

  create_table "phone_numbers", :force => true do |t|
    t.string   "number"
    t.string   "kind"
    t.integer  "phone_numberable_id"
    t.string   "phone_numberable_type"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "phone_numbers", ["phone_numberable_id", "phone_numberable_type"], :name => "index_phone_numbers_on_phone_numberable"
  add_index "phone_numbers", ["phone_numberable_type"], :name => "index_phone_numbers_on_phone_numberable_type"

  create_table "readings", :force => true do |t|
    t.integer  "message_id"
    t.datetime "created_at"
  end

  add_index "readings", ["message_id"], :name => "index_readings_on_message_id"

  create_table "scholar_hours", :force => true do |t|
    t.integer  "student_id"
    t.string   "reason"
    t.date     "date_assigned"
    t.date     "date_served"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "status"
    t.string   "comments"
  end

  add_index "scholar_hours", ["date_assigned", "status", "student_id"], :name => "index_scholar_hours_on_date_assigned_and_status_and_student_id"
  add_index "scholar_hours", ["date_assigned", "status"], :name => "index_scholar_hours_on_date_assigned_and_status"
  add_index "scholar_hours", ["date_assigned"], :name => "index_scholar_hours_on_date_assigned"
  add_index "scholar_hours", ["status", "date_assigned", "student_id"], :name => "index_scholar_hours_on_status_and_date_assigned_and_student_id"
  add_index "scholar_hours", ["status"], :name => "index_scholar_hours_on_status"
  add_index "scholar_hours", ["student_id", "date_assigned"], :name => "index_scholar_hours_on_student_id_and_date_assigned"
  add_index "scholar_hours", ["student_id", "status"], :name => "index_scholar_hours_on_student_id_and_status"
  add_index "scholar_hours", ["student_id"], :name => "index_scholar_hours_on_student_id"

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

  add_index "student_action_types", ["name"], :name => "index_student_action_types_on_name"
  add_index "student_action_types", ["student_action_category_id"], :name => "index_student_action_types_on_student_action_category_id"
  add_index "student_action_types", ["value"], :name => "index_student_action_types_on_value"

  create_table "student_actions", :force => true do |t|
    t.integer  "enrollment_id"
    t.integer  "student_action_type_id"
    t.string   "comment"
    t.date     "date",                   :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "deposit_id"
  end

  add_index "student_actions", ["date"], :name => "index_student_actions_on_date"
  add_index "student_actions", ["enrollment_id", "student_action_type_id"], :name => "index_student_actions_on_enrollment_and_student_action_type"
  add_index "student_actions", ["student_action_type_id"], :name => "index_student_actions_on_student_action_type_id"

  create_table "students", :force => true do |t|
    t.string   "gender",                           :null => false
    t.date     "birthday",                         :null => false
    t.string   "address"
    t.string   "ccsd_id",                          :null => false
    t.integer  "grade_level",                      :null => false
    t.string   "email"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "registration_code"
    t.integer  "bank_balance",      :default => 0
  end

  add_index "students", ["ccsd_id"], :name => "index_students_on_ccsd_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "submissions", :force => true do |t|
    t.integer  "student_id",                       :null => false
    t.integer  "assignment_id",                    :null => false
    t.float    "points_earned", :default => 0.0,   :null => false
    t.datetime "created_at"
    t.boolean  "archived",      :default => false
    t.string   "term"
    t.integer  "term_id"
  end

  add_index "submissions", ["archived"], :name => "index_submissions_on_archived"
  add_index "submissions", ["assignment_id"], :name => "index_submissions_on_assignment_id"
  add_index "submissions", ["student_id", "assignment_id"], :name => "index_submissions_on_student_id_and_assignment_id"
  add_index "submissions", ["term"], :name => "index_submissions_on_term"
  add_index "submissions", ["term_id", "student_id"], :name => "index_submissions_on_term_id_and_student_id"
  add_index "submissions", ["term_id"], :name => "index_submissions_on_term_id"

  create_table "teachers", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "terms", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
