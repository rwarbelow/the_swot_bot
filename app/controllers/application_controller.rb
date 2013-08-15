class ApplicationController < ActionController::Base

	include ApplicationHelper
	
  protect_from_forgery

  before_filter :user_auth

  def user_auth
    redirect_to error_url unless current_user
  end

  def current_user
    @current_user ||= UserIdentity.find_by_id(session[:user_id])
  end
end
