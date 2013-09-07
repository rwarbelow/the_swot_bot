class Students::ProfilesController < Students::BaseController
  def show
    @student = current_student
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
    @student = current_student
    if @student.update_attributes(params[:student])
      flash[:success] = "Profile updated"
      redirect_to students_profile_path
    else
      @errors = @student.errors.full_messages
      @student = current_student
      render 'edit'
    end
  end

  def update_identity
    @user = current_student.identity
    if @user.update_attributes(params[:identity])
      flash[:success] = "Profile updated"
      redirect_to profile_path
    else
      @user = current_student.identity
      @errors = @user.errors.full_messages
      render 'edit'
    end
  end

end
