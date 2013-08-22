class Sms

	attr_reader :phone_number, :ccsd_id

	def initialize(phone_number, ccsd_id)
		@phone_number = phone_number
		@ccsd_id = ccsd_id
	end

	def student_name
		student = Student.find_by_ccsd_id(ccsd_id)
		student_first_name = student.first_name
		student_last_initial = student.last_name[0].capitalize	
		first_name = student_first_name.capitalize
		@student_name = "#{first_name}.#{student_last_initial}"
	end

	def todays_date
		Date.today.strftime("%m/%d")
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
		value_totals = Hash.new
		student.student_actions.select {|action| action.date == Date.today}.each do |action|
			value_totals["positive"]
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

	def mastery
		mastery_score = 0
		total_occurances = 0 
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category == 3
				mastery_score += (no_of_occurances * student_action_type.value)
				total_occurances += no_of_occurances
			end
			mastery_score / total_occurances
		end
	end

	def positive
		positive_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category == 2 && student_action_type.value == 1
				positive_score =+ no_of_occurances
			end
		end
	end

	def negative
		negative_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category == 2 && student_action_type.value == -1
				negative_score =+ no_of_occurances
			end
		end
	end

	def missing_assignments
		missing_assignments_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category == 4
				missing_assignments_score += no_of_occurances
			end
		end
	end

	def prepare_text_body(student_actions_hash)
		on_time = student_actions_hash[1]
		tardy = student_actions_hash[2]
		absent = student_actions_hash[3]

		text_body =
<<-EOS
#{student_name} #{todays_date}
Attendance: On-Time:#{on_time}, Tardy: #{tardy}, Absent: #{absent}
Behavior: Positive: #{postive}, Negative: #{negative}
Mastery : #{mastery}
Missing Assignments: #{missing_assignments_score}
EOS
		
		student_actions_hash.each do |key, value|
    	text_body << "#{StudentActionType.find(key).name}: #{value} "
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

	
