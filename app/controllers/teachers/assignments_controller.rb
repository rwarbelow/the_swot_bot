class Teachers::AssignmentsController < Teachers::BaseController

  def index
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments
  end
end
