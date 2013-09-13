class Sms

	attr_reader :phone_number, :ccsd_id, :twilio_format

	def initialize(phone_number, ccsd_id)
		@twilio_format = phone_number
		@phone_number = phone_number.split('').pop(10).join('')
		@ccsd_id = ccsd_id
	end

	def student_name
		student = Student.find_by_ccsd_id(ccsd_id)
		student_last_initial = student.last_name[0].capitalize	
		first_name = student.first_name.capitalize
		student_name = "#{first_name} #{student_last_initial}."
	end

	def todays_date
		Date.today.strftime("%m/%d")
	end

	def	initiate_response
		if Guardian.valid_number?(phone_number)
			guardian = PhoneNumber.find_by_number(phone_number).phone_numberable
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
		@student_actions_hash = Hash.new(0)
		student_actions_array.each do |n|
			@student_actions_hash[n] +=1
		end
		prepare_text_body(@student_actions_hash)
	end

	def mastery(student_actions_hash)
		mastery_score = 0
		total_occurances = 0 
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category_id == 3
				mastery_score += (no_of_occurances.to_i * student_action_type.value.to_i)
				total_occurances += no_of_occurances
			end
		end 
		return "#{mastery_score} of #{total_occurances}"
	end

	def positive(student_actions_hash)
		positive_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			p student_action_type
			if student_action_type.student_action_category_id == 2 && student_action_type.value == "1"
				positive_score += no_of_occurances
			end
		end
		return positive_score
	end

	def negative(student_actions_hash)
		negative_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category_id == 2 && student_action_type.value == "-1"
				negative_score += no_of_occurances
			end
		end
		return negative_score
	end

	def missing_assignments(student_actions_hash)
		missing_assignments_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category_id == 4
				missing_assignments_score += no_of_occurances
			end
		end
		return missing_assignments_score
	end

	def prepare_text_body(student_actions_hash)
		on_time = student_actions_hash[1]
		tardy = student_actions_hash[2]
		absent = student_actions_hash[3]
		positive = positive(student_actions_hash)
		negative = negative(student_actions_hash)
		missing_assignments = missing_assignments(student_actions_hash)
		text_body =
<<-EOS
#{student_name} #{todays_date}

Attendance
On time: #{on_time}, Tardy: #{tardy}, Absent: #{absent}

Behavior
Positive: #{positive}, Negative: #{negative}

Missing Assignments
#{missing_assignments}
EOS

		if text_body.length < 160
			send_sms_reply(text_body)
		else
			send_sms_reply("text message too long")
		end
	end

	def error_reply
		TextMessage.sendMessage({to: twilio_format,
														 message: "We're sorry, but we could not process your request. Please contact your student's Teacher."})
	end

	def send_sms_reply(text_body)
		TextMessage.sendMessage({to: twilio_format,
														 message: text_body })	
	end
end


