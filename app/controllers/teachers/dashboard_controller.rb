class Teachers::DashboardController < Teachers::BaseController
  def index
  end

  def daily_summary
  	@students = Student.includes(:identity, :student_actions).all.sort!{ |a, b| a.last_name <=> b.last_name}
  end

end
