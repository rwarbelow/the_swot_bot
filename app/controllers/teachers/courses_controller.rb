 class Teachers::CoursesController < Teachers::BaseController

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
    @course.teacher_id = current_teacher
    if @course.save
      redirect_to teachers_course(@course)
    else
      @errors = @teacher.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
    if @teacher && @teacher.id == current_user.teacher.id
      render 'teachers/teachers/edit'
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
    @students = Course.find(8).students
  end
end
