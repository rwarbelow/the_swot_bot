class Students::ReportsController < Students::BaseController
  def swot_report
	 students = Student.where(:ccsd_id => params[:ccsd_id])

		new_report(students, password = false)
	end
end
