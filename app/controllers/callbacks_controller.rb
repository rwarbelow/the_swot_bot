class CallbacksController < ApplicationController

	def cloud_elements
		puts "called cloud_elements"	
	  from = params['From']
	  student_id = params['Body'].strip
	  p student_id 
	  p from
		render nothing: true
	end
end
