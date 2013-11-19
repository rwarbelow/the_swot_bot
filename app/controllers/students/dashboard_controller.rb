class Students::DashboardController < Students::BaseController
  def index
  	@student = current_student
    @bonuses = @student.positive(@student.collect_student_actions)
  	@incompleted_goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "In Progress"}
  	@completed_goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "Complete"}
    @incomplete_scholar_hours = ScholarHour.where(student_id: current_student.id).where(status: "Not Complete")
    @completed_scholar_hours = ScholarHour.where(student_id: current_student.id).where(status: "Complete")
  end

  def completed_scholar_hours
    @completed_scholar_hours = ScholarHour.where(student_id: current_student.id).where(status: "Complete")
  end

  def bank_account
    @number = params[:number].nil? ? 1 : params[:number].to_i
    @student_actions = current_student.student_actions.where('date > ?', (Date.today - @number))
  end
end
