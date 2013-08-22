module EmailHelper

	def	weekly_email
		guardians = Guardian.where("email IS NOT NULL")
		guardians.each do |guardian|
			guardian.students.each do |student|
				send_email(guardian, student.ccsd_id)
			end
		end
	end

	def send_student_email(guardian_username, ccsd_id)
		guardian = Identity.find_by_username(guardian_username).guardian
		
		if check_student_guardian_relationship(guardian, ccsd_id)
			send_email(guardian, ccsd_id)
		else
			flash[:error] = "Undefined Student Guardian relationship"
			#render INSERT PATH HERE 
		end
	end

	def	send_email(guardian, ccsd_id)
		student = Student.find_by_ccsd_id(ccsd_id)
		Email.sendEmail({from: 'noreply@swotbot.org',
												 to: guardian.email,
												 subject: "#{student.first_name.capitalize}'s Swot Report for the week of #{(Date.today.end_of_week) -2}", message: "Check out your students weekly report <a href='http://still-chamber-4019.herokuapp.com/guardians/student_report?ccsd_id=#{ccsd_id}'>Here</a>" })
	end
	http://localhost:3000/guardians/student_report?ccsd_id=3333334 @ericallen

	def check_student_guardian_relationship(guardian, ccsd_id)
		guardian.students.find { |student| student.ccsd_id == ccsd_id }
	end
end





