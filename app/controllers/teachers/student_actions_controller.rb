class Teachers::StudentActionsController < Teachers::BaseController

  def new
    @course = current_teacher.courses.find(params[:course_id])
    @students = @course.students
  end

  def create
    errors = []
    @course = current_teacher.courses.find(params[:course_id])
    params[:student_ids].each do |student_id|
      enrollment = Enrollment.find_by_student_id_and_course_id(student_id, @course.id)
      enrollment.student_actions << StudentAction.create(:date => params[:date], :student_action_type_id => params[:student_action], :comment => params[:comment])
      errors << "#{Student.find(student_id).first_name} #{Student.find(student_id).last_name} : #{enrollment.errors.full_messages.first}" unless enrollment.save
    end
    flash[:enrollment_errors] = errors
    redirect_to teachers_course_history_actions_path(@course)
  end

  def index
    @courses = current_teacher.courses.includes(:subject,:student_actions)
  end

  def edit
    @student_action = StudentAction.find(params[:id])
    session[:last_page] = request.env['HTTP_REFERER'] || teachers_livestream_path
  end

  def update
    @student_action = StudentAction.find(params[:id])
    if @student_action.update_attributes(params[:student_action])
      flash[:success] = "Action updated!"
      redirect_to session[:last_page]
    else
      flash[:action_errors] = @student_action.errors.full_messages
      render 'edit'
    end
  end

  def course_history
    @course = Course.find(params[:id])
    @number = params[:number].nil? ? 2 : params[:number].to_i
  end

  def destroy
    session[:last_page] = request.env['HTTP_REFERER'] || teachers_livestream_path
    @action = StudentAction.find(params[:id])
    @course = Course.find(@action.enrollment.course_id)
    flash[:delete_confirmation] = "#{@action.student_action_type.name} deleted for #{@action.enrollment.student.first_name}"
    @action.delete
    redirect_to session[:last_page]
  end
end
