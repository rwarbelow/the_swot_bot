class Teachers::BaseController < ApplicationController
	before_filter :require_teacher

  #TODO: Move this into model & refactor
  def student_attendance(students, course)
    attendances = {'on-time' => [], 'tardy' => [], 'absent' => []}
    students.each do |student|
      enrollment = Enrollment.where(course_id: course.id, student_id: student.id).first
      attendance = Attendance.where(enrollment_id: enrollment.id, date: Date.today).first_or_initialize(status_id: 1)
      attendances[Attendance::STUDENT_ACTION_STATUS_NAMES[Attendance::STATUS_IDS[attendance.status_id]]] << student.id
    end
    attendances
  end

  def student_assignments(students)
    missing_assignments = []

    students.each do |student|
      missing_assignments << student.student_actions.where(student_action_type_id: 29, date: Date.today).first
    end

    assignments = {}
    missing_assignment_ids = []

    missing_assignments.compact.each do |student_action|
      missing_assignment_ids << student_action.enrollment.student_id
    end

    assignments[:missing_assignments] = missing_assignment_ids
    p assignments
  end

  #TODO: Move this into model
  def save_action(action, student_ids, course_id)

    if student_ids
      student_ids.each do |student_id|

        action_type = StudentActionType.find_by_name(action.to_s)
        student = Student.find(student_id.to_i)
        enrollment = student.enrollments.find_by_course_id(course_id)
        
        # Idea of what to call when code is moved into the model
        # student_action = StudentAction.new(enrollment_id: enrollment.id, 
        #                                    date: Date.today, 
        #                                    action_type_id: action_type.id)
        # student_action.save_or_update!
        if !action_type.category.allow_multiple_entries_per_date?
          # find the preexising database row for the existing action of this 
          # same family and update its action_type_id
          student_action_of_same_family = StudentAction.where(
                                                          enrollment_id: enrollment.id, 
                                                          date: Date.today, 
                                                          student_action_type_id: [action_type.category.student_action_types.map(&:id)]
                                                        ).first

          if student_action_of_same_family
            student_action_of_same_family.update_attribute(:student_action_type_id, action_type.id)
            next
          end
        end
        
        student_action = StudentAction.create(enrollment_id: enrollment.id,
                                              date: Date.today,
                                              student_action_type_id: action_type.id)
      end
    end
  end

  def save_attendance(absent_students, tardy_students, present_students, course_id)
    Attendance.save_for_student_ids(present_students, tardy_students, absent_students, course_id)
  end

  def save_assignments(student_ids, course_id, assignment_id)
    student_ids.each do |student_id|
      student = Student.find(student_id)
      enrollment = student.enrollments.find_by_course_id(course_id)
      assignment = Assignment.find(assignment_id)
      StudentAction.create!(enrollment_id: enrollment.id,
                            date: Date.today,
                            student_action_type_id: 29,
                            comment: assignment.title
                            )
    end
  end

	def require_teacher
	  return true if current_teacher?
	  redirect_to root_path and return false
	end
end
