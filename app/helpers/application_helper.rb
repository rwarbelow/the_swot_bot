module ApplicationHelper
  def current_user
    @current_user ||= Identity.find_by_id(session[:user_id])
  end

  def current_admin
    current_user and current_user.admin
  end

  def current_admin?
    !!current_admin
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

  def start_date
    if Time.now.wday != 5
      Date.commercial(Date.today.year, Date.today.cweek-1, 1)
    else
      Date.commercial(Date.today.year, Date.today.cweek, 1)
    end
  end

  def end_date
    if Time.now.wday != 5
      Date.commercial(Date.today.year, Date.today.cweek-1, 5)
    else
      Date.commercial(Date.today.year, Date.today.cweek, 5)
    end
  end
end
