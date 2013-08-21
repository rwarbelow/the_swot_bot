class CallbacksController < ApplicationController

	def cloud_elements
	  from = params['From']
	  ccsd_id = params['Body'].strip
	  puts from 
	  puts ccsd_id
	  puts "*" * 80
	  puts params

	  message = Sms.new(from, ccsd_id)
		message.initiate_response

		render nothing: true
	end
end
