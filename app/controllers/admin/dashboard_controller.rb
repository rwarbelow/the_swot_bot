class Admin::DashboardController < Admin::BaseController
  def index
  	@new_scholar_hours = ScholarHour.where(date_assigned: Date.today, status: "Not Complete")
  end

  def guardian_logins
  	@guardians = Guardian.all
  end

  def student_logins
  	@students = Student.all
  end
end
