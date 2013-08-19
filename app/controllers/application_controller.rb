class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  def profile_path
    if current_student?
      p session
      :students_root
    elsif current_guardian?
      p session
      :guardians_root
    elsif current_teacher?
      p session
      :teachers_root
    else
      raise RuntimeError, "User Identity #{@user.id} has no profile"
    end
  end
end
