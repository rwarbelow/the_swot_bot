 class Teachers::CoursesController < Teachers::BaseController

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
    @course.teacher_id = current_teacher.id
    if @course.save
      redirect_to teachers_course_path(@course)
    else
      @errors = @course.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
    @teacher = @course.teacher
    if @course && @teacher.id == current_user.teacher.id
      render 'teachers/courses/edit'
    else
      redirect_to error_url
    end
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update_attributes(params[:teacher])
      flash[:success] = "Profile updated"
      redirect_to teacher_path(@teacher)
    else
      @errors = @teacher.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    Teacher.find(params[:id]).destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
    @course = Course.find(params[:id])
    @students = @course.students
  end
end
