class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  def profile_path
    if @user.student?
      :student_root
    elsif @user.guardian?
      :guardian_root
    elsif @user.teacher?
      :teacher_root
    else
      raise RuntimeError, "User Identity #{@user.id} has no profile"
    end
  end
end
