 class Teachers::CoursesController < Teachers::BaseController

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
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
    @teacher = @course.teacher
    if @course && @teacher.id == current_user.teacher.id
      render 'teachers/courses/edit'
    else
      redirect_to error_url
    end
  end

  def update
    @teacher = current_teacher
    if @teacher.update_attributes(params[:teacher])
      flash[:success] = "Profile updated"
      redirect_to teacher_path(@teacher)
    else
      @errors = @teacher.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    current_teacher.courses.find(params[:id]).destroy
    flash[:success] = "Course deleted."
    redirect_to root_url
  end

  def show
    @course = Course.includes(:subject).find(params[:id])
    @students = @course.students.includes(:identity)
  end

  def index
    @courses = Course.includes(:subject).order(params[:sort])
  end

  def courseload
    @courses = current_teacher.courses.includes(:subject)
  end

  def roster
    @course = Course.find(params[:course_id])
    @students = @course.students.includes(:identity)
  end

  def student_record
    @student = Student.find(params[:student_id])
    @course = Course.find(params[:course_id])
  end

  def print_gradebook
    @course = Course.find(params[:course_id])
    render :layout => false
  end

end
