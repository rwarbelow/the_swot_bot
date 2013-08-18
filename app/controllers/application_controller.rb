class ApplicationController < ActionController::Base

	include ApplicationHelper
	
  protect_from_forgery

  before_filter :user_auth, :set_session_user_type
end
