module StudentsHelper
  def require_student
    redirect_to error_url unless current_student?
  end
end
