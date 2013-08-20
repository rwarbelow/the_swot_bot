class Students::BaseController < ApplicationController
	before_filter :require_student
	def require_student
	  return true if current_student?
	  redirect_to root_path and return false
	end
end
