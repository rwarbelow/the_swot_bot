class Teachers::BaseController < ApplicationController

  def enrolled_or_teaching
    return true if current_student? and current_student.enrolled_in?(@course)
    return true if current_teacher? and current_teacher.teaching?(@course)

    redirect_to root_path and return false
  end

  def save_action(action, student_ids, course_id)
    student_ids.each do |student_id|
      action_name = StudentActionType.find_by_name(action)
      student = Student.find(student_id.to_i)
      enrolled = student.enrollments.where(course_id: course_id).first
      new_record = StudentAction.new(date: Date.today, enrollment_id: enrolled.id, student_action_type_id: action_name.id)
      new_record.save
    end
  end

  def save_attendance(absent_students, tardy_students, present_students, course_id)
    save_action("absent", absent_students, course_id)
    save_action("tardy", tardy_students, course_id)
    save_action("on-time", present_students, course_id)
  end
end
