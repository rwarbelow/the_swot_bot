class Teachers::DashboardController < Teachers::BaseController
  def index
  end

  def daily_summary
  	@students = Student.includes(:identity, :student_actions).sort!{ |a, b| a.last_name <=> b.last_name}.all
  end

end
