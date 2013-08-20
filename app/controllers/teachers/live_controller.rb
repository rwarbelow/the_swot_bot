class Teachers::LiveController < Teachers::ApplicationController

  def classroom
    @course = Course.find(params[:course_id])
    @students = @course.students.all
  end

  def create_action
    action = StudentActionType.find_by_name(params[:action_name])
    course_id = params[:course_id]
    student_ids = params[:student_ids]

    absent_students = params[:absent]
    tardy_students = params[:tardy]
    present_students = params[:present]

    save_action(action, student_ids, course_id) if student_ids
    
    save_attendance(absent_students, tardy_students, present_students, course_id) if present_students

    render :json => "SUCCESS!"
  end
end
