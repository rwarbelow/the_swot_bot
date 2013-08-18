module StudentsHelper
  def require_student
    redirect_to error_url unless current_user.session_user_type == :StudentProfile
  end
end
