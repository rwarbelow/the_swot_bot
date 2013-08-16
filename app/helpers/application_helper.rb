module ApplicationHelper
	def current_user
    @current_user ||= UserIdentity.find_by_id(session[:user_id])
  end
   def user_auth
    redirect_to error_url unless current_user
  end
end
