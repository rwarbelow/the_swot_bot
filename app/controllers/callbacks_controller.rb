class CallbacksController < ApplicationController

	def cloud_elements
    # do not merge temporary debugging code/logging
	  from = params['From']
	  student_id = params['Body'].strip
		render nothing: true
	end
end
