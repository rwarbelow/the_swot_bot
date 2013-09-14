class Students::DashboardController < Students::BaseController
  def index
  	@student = current_student
  	@goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "In Progress"}
  	@completed_goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "Complete"}
    @incomplete_scholar_hours = ScholarHour.where(student_id: current_student.id).where(status: "Not Complete")
    @completed_scholar_hours = ScholarHour.where(student_id: current_student.id).where(status: "Complete")
  end

  def completed_scholar_hours
    @completed_scholar_hours = ScholarHour.where(student_id: current_student.id).where(status: "Complete")
  end

end
