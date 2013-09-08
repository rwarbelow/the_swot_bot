class Teachers::AssignmentsController < Teachers::BaseController

  def index
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments.sort! { |a,b| a.due_date <=> b.due_date }
  end

  def create
    @course = current_teacher.courses.find(params[:course_id])
    @assignment = Assignment.new(params[:assignment])
    @assignment.course_id = @course.id
    if @assignment.save
      redirect_to teachers_course_path(@course)
    else
      flash[:assignment_errors] = @assignment.errors.full_messages
      @assignments = @course.assignments
      render 'teachers/assignments/index'
    end
  end

  def edit
    @assignment = Assignment.find(params[:id])
    @course = @assignment.course
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def update
    @assignment = Assignment.find(params[:id])
    @assignment.update_attributes(params[:assignment])
    if @assignment.save
      redirect_to teachers_course_path(@assignment.course)
    else
      flash[:assignment_errors] = @assignment.errors.full_messages
      render '/teachers/assignments/edit'
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @course = @assignment.course
    @assignment.destroy
    redirect_to teachers_course_path(@course)
  end

end
