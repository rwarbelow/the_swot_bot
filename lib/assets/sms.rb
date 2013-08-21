#this method recieves a text, takes  the number and the text body "student_id" and verifies if the guardian phone number matches the student id
#this method returns a student object

class Sms

	attr_reader :phone_number, :ccsd_id

	def initialize(phone_number, ccsd_id)
		@phone_number = phone_number
		@ccsd_id = ccsd_id
	end
	# require 'pry'
	def	initiate_response
		if guardian = Guardian.valid_number?(phone_number)
			p "before check student guardian"

			check_student_guardian_relationship(guardian, ccsd_id)
			p "after check student guardian"
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
														 message: "We're sorry, but we could not process your request. Please contact your students Teacher."})
	end

	def send_sms_reply(text_body)
		# binding.pry
		TextMessage.sendMessage({to: phone_number,
														 message: text_body })	
	end
end

	
# @student_actions_array = []

# def validate_guardian
# 	@guardian = Guardian.find_by_number(@phone_number)
# 	students = @guardian.students
# 	students.any? { |student| student.ccsd_id == @student_id }
# end

# def validate_guardian_and_return_student # rename? find student by validating guardian
# 	Guardian.find(PhoneNumber.find_by_number(@phone_number).phone_numberable_id).students.select {|student| student.ccsd_id == @student_id}.first
# end

# # this returns ALL (even duplicates) student_action_type_ids 
# def student_info_array
# 	student = validate_guardian_and_return_student(@phone_number, @student_id)
# 	student.student_actions.select {|action| action.date == Date.today}.each do |action|
# 		@student_actions_array << action.student_action_type_id
# 	end
# end

# # this creates a hash with key-value pairs for student_action_type_id numbers 
# # and the number of times they appeared in the array

# # this returns things like "incomplete-classwork: 2"
# def list_daily_student_behaviors
# 	@student_actions_hash.each do |key, value|
# 		p "#{StudentActionType.find(key).name}: #{value}"
# 	end
# end




# We recieve a text message from a guardian with a students ccsd_id number
	# Verify that the ccsd_id number, and the number the text came from exist in
	# the guardian relationship

	# Once verified, respond with a text message that is less than 160 characters long
			# Attendance: Tardy: 1, Absent: 2
			# Behavior: Positive: 3, Negative: 3
			# Academic: Mastery : Poor, Missing Assignments: 0 
			# The above text is 118 characters

	#breaking down the above

			#Attendance 
				# find all student actions for today that have the student_action_category_type of 'attendance'
					# take each, "on-time", "tardy" and "absent" and aggregate the instances into a hash
					# Attendance_hash = {on-time: 2, tardy: 1, absent: 3} => this must always add up to 6 classes
					# we will likely leave out any on-time to save characters, and if all on time... still display
						# Attendance: Tardy: 0, Absent: 0
			#Behavior
				# find all student actions for today that have the student_action_category_type of 'behavior'
					# take each behavior type and aggregate into a hash, couting each instance of behavior type
					# count up all positives and negatives based on score and display 
						# Behavior: Positive: 3, Negative: 3
					# behavior_hash = {'resisting-distractions' => 0,
					#                  'baby-attack' => 0,
					#                  'causing-distractions' => 0,
					#                  'sloppy-work' => 0,
					#                  'helping-others' => 0,
					#                  'integrity' => 0,
					#                  'leadership' => 0,
					#                  'perseverance' => 0,
					#                  'problem-solving' => 0,
					#                  'respect-to-others' => 0,
					#                  'team-work' => 0,
					#                  'working-independently' => 0,
					#                  'calling-out' => 0,
					#                  'disrespecting-others' => 0,
					#                  'ignoring-instructions' => 0,
					#                  'laughing-at-others-mistakes' => 0,
					#                  'not-participating' => 0,
					#                  'side-conversations' => 0,
					#                  'sloppy-slant' => 0,
					#                  'swearing' => 0,}
					# once this hash is created, we only want to return the behaviors that do not have a 0 

			# Academic
				# find all student actions for today that have the student_action_category_type of 'academic'
					# take each 'academic' type and aggregate into a hash, couting each instance of academic type
					# adademic_hash = {'mastered-daily-goal' => 0,
					#                  'incomplete-classwork' => 0,
					#                  'did-not-master-daily-goal' => 0,
					#                  'missing-assignment' => 0}
