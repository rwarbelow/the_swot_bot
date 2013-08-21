class DeliverEmail

	attr_reader :to, :from, :subject, :message

	def initialize(email_hash)
		@to = email_hash[:to]
		@from = email_hash[:from]
		@subject = email_hash[:subject]
		@message = email_hash[:message]
	end

	def	initiate_email
		if guardian = Guardian.valid_email?(to)
			check_student_guardian_relationship(guardian, ccsd_id)
		end
	end
	
	def check_student_guardian_relationship(guardian, ccsd_id)
		if student = guardian.students.find { |student| student.ccsd_id == ccsd_id }
			collect_student_actions(student)
		end
	end
end

# this class is responsible for sending emails to parents each with with their childs report check_student_guardian_relationship
# Step 1.) Iterate over all guardians and extract the email address for every guardian who has one
# Step 2.) Iterate over 
