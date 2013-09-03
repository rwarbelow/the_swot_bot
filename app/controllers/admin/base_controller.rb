class Admin::BaseController < ApplicationController
	before_filter :require_admin

  def require_admin
  	return true if current_admin?
	  redirect_to root_path and return false
  end
end
