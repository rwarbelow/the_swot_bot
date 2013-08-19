class Teachers::LiveController < Teachers::ApplicationController

  def classroom
    course = Course.find(params[:course_id])
    p course
    @students = course.students.all
  end
end
