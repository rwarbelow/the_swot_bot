class Teachers::TeacherProfilesController < Teachers::BaseController
  
  def new
    @teacher_profile = TeacherProfile.new
  end

  def create
    @teacher_profile = TeacherProfile.new(params[:teacher_profile])
    if @teacher_profile.save
      session[:teacher_profile_id] = @teacher_profile.id
      redirect_to new_user_identity_path
    else
      @errors = @teacher_profile.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end

  def edit
    @teacher_profile = TeacherProfile.find(params[:id])
    if @teacher_profile && @teacher_profile.id == current_user.teacher_profile.id
      render 'teachers/teacher_profiles/edit'
    else
      redirect_to error_url
    end
  end

  def update
    @teacher_profile = TeacherProfile.find(params[:id])
    if @teacher_profile.update_attributes(params[:teacher_profile])
      flash[:success] = "Profile updated"
      redirect_to teacher_profile_path(@teacher_profile)
    else
      @errors = @teacher_profile.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
  end
end
