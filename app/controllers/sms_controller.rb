class SmsController < ApplicationController

	def broadcast
		students = Student.find(params[:sms][:student_ids].keys)
		SmsBroadcaster.broadcast(students, params[:sms][:body])
		flash[:message_sent] = "SMS Messages Sent :) "
		redirect_to messages_path
	end

end
