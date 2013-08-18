module ApplicationHelper
	def current_user
    @current_user ||= UserIdentity.find_by_id(session[:user_id])
  end

  def current_student
    current_user and current_user.student_profile
  end

  def current_student?
    !!current_student
  end

  def current_teacher
    current_user and current_user.teacher_profile
  end

  def current_teacher?
    !!current_teacher
  end
  
  def current_guardian
    current_user and current_user.guardian_profile
  end

  def current_guardian?
    !!current_guardian
  end

  def user_auth
    redirect_to error_url unless current_user
  end

  def set_session_user_type
    if @current_user 
      raise "Warning: User type not set" unless session[:session_user_type].present?
      @current_user.session_user_type = session[:session_user_type]
    end
  end
end
