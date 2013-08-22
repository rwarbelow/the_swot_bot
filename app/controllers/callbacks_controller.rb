class CallbacksController < ApplicationController

	def cloud_elements
	  from = params['From']
	  ccsd_id = params['Body'].strip

	  message = Sms.new(from, ccsd_id)
		message.initiate_response

		render nothing: true
	end
end
