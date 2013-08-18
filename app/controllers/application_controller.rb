class ApplicationController < ActionController::Base

  protect_from_forgery

  def profile_path
    if @user.student?
      :students_root
    elsif @user.guardian?
      :guardians_root
    elsif @user.teacher?
      :teachers_root
    else
      raise RuntimeError, "User Identity #{@user.id} has no profile"
    end
  end
end
