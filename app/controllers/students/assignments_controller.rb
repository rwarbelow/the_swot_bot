class AssignmentsController < Students::BaseController
  before_filter :load_course_and_assignments
  before_filter :enrolled_or_teaching, :only => [:show]


  def index
  end

  private

  def load_course_and_assignments
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments
  end 
end
