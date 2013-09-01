class Students::DashboardController < Students::BaseController
  def index
  	@student = current_student
  	@goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "In Progress"}
  	@completed_goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "Complete"}
  	@assignments = []
    @student.courses.each do |course|
      course.assignments.each do |assignment|
        @assignments << assignment if assignment.due_date > Date.today
      end
    end
  end
end
