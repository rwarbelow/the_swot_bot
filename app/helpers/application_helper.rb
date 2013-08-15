module ApplicationHelper
	def current_user
    @current_user ||= UserIdentity.find_by_id(session[:user_id])
  end
end
