class Teachers::BaseController < ApplicationController
	before_filter :require_teacher

  #TODO: Move this into model & refactor
  def student_attendance(students)
    on_time, tardy, absent = [], [], []

    students.each do |student|
      on_time << student.student_actions.where(student_action_type_id: 1, date: Date.today).first
      tardy << student.student_actions.where(student_action_type_id: 2, date: Date.today).first
      absent << student.student_actions.where(student_action_type_id: 3, date: Date.today).first
    end

    attendance = {}
    on_time_ids, tardy_ids, absent_ids = [], [], []

    on_time.compact.each do |student_action|
      on_time_ids << student_action.enrollment.student_id
    end

    tardy.compact.each do |student_action|
      tardy_ids << student_action.enrollment.student_id
    end

    absent.compact.each do |student_action|
      absent_ids << student_action.enrollment.student_id
    end

    attendance[:on_time] = on_time_ids
    attendance[:tardy] = tardy_ids
    attendance[:absent] = absent_ids
    attendance
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
    save_action("absent", absent_students, course_id)
    save_action("tardy", tardy_students, course_id)
    save_action("on-time", present_students, course_id)
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
