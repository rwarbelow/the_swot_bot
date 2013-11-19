class TermsController < ApplicationController
	def change_term
		session[:term_id] = params[:term][:term_id]
		redirect_to(:back)
	end
end
