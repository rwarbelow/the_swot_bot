class AssignmentsController < Students::BaseController
  before_filter :load_course_and_assignments

  def show
  end

  private

  def load_course_and_assignments
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments
  end
end
