class Teachers::StudentProfilesController < Teachers::BaseController
  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
    @user = @student.identity
    if @student && @student.id == current_user.student.id
      render 'students/students/edit'
    else
      redirect_to error_url
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:success] = "Profile updated"
      redirect_to student_path
    else
      @errors = @student.errors.full_messages
      render 'edit'
    end
  end

  def new
    @student = Student.new
  end

  def create
    birthday = "#{params[:student]['birthday(1i)']}-#{params[:student]['birthday(2i)']}-#{params[:student]['birthday(3i)']}"
    address = "#{params[:student][:address_line_1]} #{params[:student][:address_line_2]} #{params[:student][:address_city]} #{params[:student][:address_state]} #{params[:student][:address_zip_code]}"
    @student = Student.new(:gender => params[:student][:gender],
                           :birthday => birthday,
                           :address => address,
                           :ccsd_id => params[:student][:ccsd_id],
                           :grade_level => params[:student][:grade_level])
    if @student.save!
      session[:new_student_id] = @student.id
      redirect_to new_identity_path
    else
      @errors = @student.errors.full_messages
      flash[:errors] = @errors
      render 'new'
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
