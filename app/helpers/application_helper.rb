module ApplicationHelper
  def current_user
    @current_user ||= Identity.find_by_id(session[:user_id])
  end
  
  def current_student
    current_user and current_user.student
  end
  
  def current_student?
    !!current_student
  end
  
  def current_teacher
    current_user and current_user.teacher
  end
  
  def current_teacher?
    !!current_teacher
  end
 
  def current_guardian
    current_user and current_user.guardian
  end
  
  def current_guardian?
    !!current_guardian
  end
end
