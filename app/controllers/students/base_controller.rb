class Students::BaseController < ApplicationController
	before_filter :require_student

	def require_student
	  redirect_to root_path and return if !current_student?
	end
end
