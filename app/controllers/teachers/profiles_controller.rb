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
    @teacher = Teacher.find(params[:id])
    @user = Identity.find(current_user.id)
    if @teacher && @teacher.id == current_user.teacher.id
      render 'teachers/profiles/edit'
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

end
