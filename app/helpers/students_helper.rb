module StudentsHelper
  def require_students
    redirect_to error_url unless current_user && current_user.student_profile_id != nil
  end
end
