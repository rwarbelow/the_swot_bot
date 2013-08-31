class ApplicationController < ActionController::Base
  before_filter: redirect_to_https
  include ApplicationHelper
  include ReportGenerator
  protect_from_forgery

  def profile_path
    if current_student?
      :students_root
    elsif current_guardian?
      :guardians_root
    elsif current_teacher?
      :teachers_root
    else
      raise RuntimeError, "User Identity #{@user.id} has no profile"
    end
  end
end


def redirect_to_https
    redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
end