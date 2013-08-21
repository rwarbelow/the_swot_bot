class Guardians::BaseController < ApplicationController
	before_filter :require_guardian

	def require_guardian
	  redirect_to root_path and return if !current_guardian?
	end
end
