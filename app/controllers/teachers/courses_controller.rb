 class Teachers::CoursesController < Teachers::BaseController

  def new
    @course = Course.new
  end

  def create
    @course = current_teacher.courses.new(params[:course])

    if @course.save
      redirect_to teachers_course_path(@course)
    else
      @errors = @course.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end

  def edit
    @course = current_teacher.courses.find(params[:id])

    if @course
      render 'teachers/courses/edit'
    else
      redirect_to error_url
    end
  end

  def update
    # im confused... why is this controller action handling updating teachers? shouldnt it be updating courses?
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

  def index
    @courses = Course.order(params[:sort])
  end

end
