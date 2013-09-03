class Teachers::ProfilesController < Teachers::BaseController
  skip_before_filter :require_teacher, :only => [:new, :create]
  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      session[:teacher_id] = @teacher.id
      redirect_to new_identity_path
    else
      @errors = @teacher.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end

  def edit
    @teacher = current_teacher
    @user = current_user
    render 'teachers/profiles/edit'
  end

  def update
    @teacher = current_teacher
    if @teacher.update_attributes(params[:teacher])
      flash[:success] = "Profile updated"
      redirect_to teachers_profile_path(@teacher)
    else
      @errors = @teacher.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    current_teacher.destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
    @courses = current_teacher.courses
  end

  def add_phone_number
    @phone_number = PhoneNumber.new(params[:phone_number])
    @phone_number.phone_numberable_id = current_teacher.id
    @phone_number.phone_numberable_type = "Teacher"
    @phone_number.save
    flash[:success] = "#{@phone_number.number} added"
    redirect_to edit_teachers_profile_path(current_teacher)
  end

  def delete_phone_number
    @phone_number = PhoneNumber.find(params[:phone_number_id])
    number = @phone_number.number
    @phone_number.destroy
    flash[:success] = "#{number} deleted"
    redirect_to edit_teachers_profile_path(current_teacher)
  end

  def update_identity
    @user = current_user
    @user.update_attributes(params[:identity])
    if @user.save
      redirect_to edit_teachers_profile_path(current_teacher)
    else
    @teacher = current_teacher
    @user = current_user
      flash[:identity_errors] = @user.errors.full_messages
      render 'teachers/profiles/edit'
    end
  end

end
