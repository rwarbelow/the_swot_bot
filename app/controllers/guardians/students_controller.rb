class Guardians::StudentsController < Guardians::BaseController
  def show
    @student = current_guardian.students.find(params[:id])
    @actions = @student.student_actions.find(:all, :order => "id ASC")
    @assignments = []
    @student.courses.each do |course|
      course.assignments.each do |assignment|
        @assignments << assignment if assignment.due_date > Date.today
      end
    end
  end
end
