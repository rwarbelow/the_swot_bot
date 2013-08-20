class Students::ProfilesController < Students::BaseController
  skip_before_filter :require_student, :only => :index
  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = current_student
    @user = @student.identity
    if @student && @student.id == current_user.student.id
      render 'edit'
    else
      redirect_to error_url
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:success] = "Profile updated"
      redirect_to student_root_path
    else
      @errors = @student.errors.full_messages
      render 'edit'
    end
  end

  def index
    if current_user.student?
      redirect_to students_root_path
    elsif current_user.guardian?
      redirect_to guardians_root_path
    elsif current_user.teacher?
      @students = Student.all
    else
      redirect_to login_path
    end
  end

end
