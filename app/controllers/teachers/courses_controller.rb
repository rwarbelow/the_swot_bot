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
    @assignments = @course.assignments.by_term(session[:term_id].to_i)
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
    @enrollment = Enrollment.where(:student_id => @student.id, :course_id => @course.id).first
    @assignments = @course.assignments.by_term(session[:term_id]).sort! { |a,b| a.due_date <=> b.due_date }
    @number = params[:number].nil? ? 3 : params[:number].to_i
    @student_actions = @enrollment.student_actions.where('date > ?', (Date.today - @number))
  end

  def print_gradebook
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments.by_term(session[:term_id]).sort! { |a,b| a.due_date <=> b.due_date }
    @term = Term.find(session[:term_id])
    render :layout => false
  end

  def attendance
    @course = Course.find(params[:id])
    @date_span = 15.days
    @date_range = date_params
    @students = @course.students.includes(:identity).order("identities.last_name")

    respond_to do |format|
      format.html
      format.csv
    end
  end

  def csv_gradebook
    @course = Course.find(params[:course_id])
    @teacher = @course.teacher
    @assignment_categories = @course.assignment_category_names
    @students = @course.students.includes(:identity).order("identities.last_name")
    @assignments = @course.assignments

    respond_to do |format|
      format.html
      format.csv
    end
  end

  private

  def date_params
    from = Date.parse(params[:from]) rescue Date.today - @date_span
    to = Date.parse(params[:to]) rescue Date.today
    if from > to
      flash.now[:error] = "Please specify a FROM date that is before the TO date"
      from = Date.today - @date_span
      to = Date.today
    end
    from..to
  end
end
