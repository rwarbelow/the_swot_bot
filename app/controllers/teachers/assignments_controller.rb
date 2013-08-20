class Teachers::AssignmentsController < Teachers::BaseController

  def index
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments
  end

  def create
    @course = Course.find(params[:course_id])
    @assignment = Assignment.new(params[:assignment])
    @assignment.course_id = @course.id
    if @assignment.save
      redirect_to teachers_course_assignments_path(@course)
    else
      flash[:assignment_errors] = @assignment.errors.full_messages
      @assignments = @course.assignments
      render 'teachers/assignments/index'
    end
  end

end
