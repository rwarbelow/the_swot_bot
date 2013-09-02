class Teachers::LiveController < Teachers::BaseController

  def classroom
    # @course = Course.find(params[:course_id])
    @course = current_teacher.courses.find(params[:course_id])
    @students = @course.students.all.sort_by { |student| student.first_name }
    @attendance = student_attendance(@students)

    respond_to do |format|
      format.json { render json: @attendance }
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

    save_action(action.name, student_ids, course_id) if student_ids
    
    # this is brittle code -- everyone could be tardy and then those tardinesses would not be saved
    save_attendance(absent_students, tardy_students, present_students, course_id) if present_students

    render :json => "SUCCESS!"
  end
end
