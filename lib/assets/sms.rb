class Sms

	attr_reader :phone_number, :ccsd_id

	def initialize(phone_number, ccsd_id)
		@phone_number = phone_number
		@ccsd_id = ccsd_id
	end

	def	initiate_response
		if guardian = Guardian.valid_number?(phone_number)
			check_student_guardian_relationship(guardian, ccsd_id)
		else
			error_reply
		end
	end

	def check_student_guardian_relationship(guardian, ccsd_id)
		if student = guardian.students.find { |student| student.ccsd_id == ccsd_id }
			collect_student_actions(student)
		else
			error_reply
		end
	end
	
	def collect_student_actions(student)
		student_actions_array = []
		student.student_actions.select {|action| action.date == Date.today}.each do |action|
  		student_actions_array << action.student_action_type_id
  	end
  	aggregate_student_behavior_hash(student_actions_array)
	end

	def aggregate_student_behavior_hash(student_actions_array) 
		student_actions_hash = Hash.new(0)
		student_actions_array.each do |n|
			student_actions_hash[n] +=1
		end
		prepare_text_body(student_actions_hash)
	end

	def prepare_text_body(student_actions_hash)
		text_body = ""
		student_actions_hash.each do |key, value|
    	text_body << "#{StudentActionType.find(key).name}: #{value}"
		end

		if text_body.length < 160
			send_sms_reply(text_body)
		else
			send_sms_reply("text message too long")
		end
	end

	def error_reply
		TextMessage.sendMessage({to: phone_number,
														 message: "We're sorry, but we could not process your request. Please contact your student's Teacher."})
	end

	def send_sms_reply(text_body)
		TextMessage.sendMessage({to: phone_number,
														 message: text_body })	
	end
end

	
