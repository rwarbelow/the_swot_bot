class Students::DashboardController < Students::BaseController
  def index
  	@student = current_student
  	@goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "In Progress"}
  	@completed_goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "Complete"}
  end
end
