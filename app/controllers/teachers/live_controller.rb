class Teachers::LiveController < Teachers::BaseController

  def classroom
    # @course = Course.find(params[:course_id])
    @course = current_teacher.courses.find(params[:course_id])
    @students = @course.students.includes(:identity).all.sort_by { |student| student.first_name }
    @attendance = student_attendance(@students)
    @assignments = student_assignments(@students)
    @assignments_due = @course.assignments.where(:due_date => Date.today)

    respond_to do |format|
      format.json { render json: { attendance: @attendance, assignments: @assignments } }
      format.html
    end
  end


  def create_action
    action = StudentActionType.find_by_name(params[:action_name])
    course_id = params[:course_id]
    student_ids = params[:student_ids]

    absent_students = params[:absent]
    tardy_students = params[:tardy]
    present_students = params[:on_time]

    assignment_id = params[:assignment_id]

    save_action(action.name, student_ids, course_id) if action

    save_assignments(student_ids, course_id, assignment_id) if assignment_id
    
    # this is brittle code -- everyone could be tardy and then those tardinesses would not be saved
    save_attendance(absent_students, tardy_students, present_students, course_id) if present_students

    render :json => "SUCCESS!"
  end
end
