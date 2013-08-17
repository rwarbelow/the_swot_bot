class Students::StudentProfilesController < Students::BaseController

  skip_before_filter :user_auth
  skip_before_filter :require_students, :only => [:new, :create]

  def show
  end

  def edit
    @student_profile = StudentProfile.find(params[:id])
    if @student_profile && @student_profile.id == current_user.student_profile.id
      render 'students/student_profiles/edit'
    else
      redirect_to error_url
    end
  end
end
