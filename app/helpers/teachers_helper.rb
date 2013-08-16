module TeacherHelper
  def require_teachers
    redirect_to error_url unless current_user && current_user.teacher_profile_id != nil
  end
end
