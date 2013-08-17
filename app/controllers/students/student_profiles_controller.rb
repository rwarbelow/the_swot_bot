require 'pry'
class Students::StudentProfilesController < Students::BaseController

  skip_before_filter :user_auth
  skip_before_filter :require_students, :only => [:new, :create]

  def show
    @student_profile = StudentProfile.find(params[:id])
  end

  def edit
    @student_profile = StudentProfile.find(params[:id])
    @user = @student_profile.user_identity
    if @student_profile && @student_profile.id == current_user.student_profile.id
      render 'students/student_profiles/edit'
    else
      redirect_to error_url
    end
  end

  def update
    @student_profile = StudentProfile.find(params[:id])
    if @student_profile.update_attributes(params[:student_profile])
      flash[:success] = "Profile updated"
      redirect_to student_profile_path
    else
      @errors = @student_profile.errors.full_messages
      render 'edit'
    end
  end

end
