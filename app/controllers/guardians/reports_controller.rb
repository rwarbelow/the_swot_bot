class Guardians::ReportsController < Guardians::BaseController
	def student_report
		students = Student.where(:ccsd_id => params[:ccsd_id])

		new_report(students)
	end
end
