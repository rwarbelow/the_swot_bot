class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :announcements, :teacher_id
    add_index :assignment_categories, :course_id
    add_index :assignments, :assignment_category_id
    add_index :attendances, :status_id
    add_index :courses, [:teacher_id, :subject_id]
    add_index :courses, :subject_id
    add_index :enrollments, [:student_id, :course_id]
    add_index :enrollments, :course_id
    add_index :goals, :student_id
    add_index :guardianships, [:student_id, :guardian_id]
    add_index :guardianships, :guardian_id
    add_index :identities, :admin_id
    add_index :identities, :teacher_id
    add_index :identities, :guardian_id
    add_index :identities, :student_id
    add_index :messages, [:author_id, :target_id]
    add_index :messages, :target_id
    add_index :phone_numbers, [:phone_numberable_id, :phone_numberable_type], :name => "index_phone_numbers_on_phone_numberable"
    add_index :phone_numbers, :phone_numberable_type
    add_index :readings, :message_id
    add_index :scholar_hours, :student_id
    add_index :student_action_types, :student_action_category_id
    add_index :student_actions, [:enrollment_id, :student_action_type_id], :name => "index_student_actions_on_enrollment_and_student_action_type"
    add_index :student_actions, :student_action_type_id
    add_index :students, :ccsd_id
    add_index :submissions, [:student_id, :assignment_id]
    add_index :submissions, :assignment_id
  end
end
