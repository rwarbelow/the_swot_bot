class ApplicationController < ActionController::Base

	include ApplicationHelper
	
  protect_from_forgery

  before_filter :user_auth


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
