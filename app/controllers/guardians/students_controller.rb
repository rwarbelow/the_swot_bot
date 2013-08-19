class Guardians::StudentsController < Guardians::BaseController
  def show
    @student = Student.find(params[:id])
    @actions = @student.student_actions.find(:all, :order => "date DESC")
    @assignments = []
    @student.courses.each do |course|
      course.assignments.each do |assignment|
        @assignments << assignment
      end
    end
  end
end
