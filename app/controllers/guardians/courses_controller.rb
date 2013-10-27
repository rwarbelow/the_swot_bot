class Guardians::CoursesController < Guardians::BaseController
  def show
    @assignments = Assignment.current.where(:course_id => params[:id]).sort! { |a,b| a.due_date <=> b.due_date }
    enrollment = Enrollment.where(:student_id => params[:student_id], :course_id => params[:id]).first
    @student = Student.find(params[:student_id])
    @student_actions = @student.student_actions.where('date > ?', (Date.today - 15))
    @course = Course.find(params[:id])
  end
end
