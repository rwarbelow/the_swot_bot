class Guardians::BaseController < ApplicationController
	before_filter :require_guardian
	def require_guardian
	  return true if current_guardian?
	  redirect_to root_path and return false
	end
end
