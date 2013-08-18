module TeachersHelper
  def require_teacher
    redirect_to error_url unless current_user.session_user_type == :TeacherProfile
  end
end
