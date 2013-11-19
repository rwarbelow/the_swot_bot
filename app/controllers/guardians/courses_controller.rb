class Guardians::CoursesController < Guardians::BaseController
  def show
    @assignments = Assignment.by_term(session[:term_id]).where(:course_id => params[:id]).sort! { |a,b| a.due_date <=> b.due_date }
    @enrollment = Enrollment.where(:student_id => params[:student_id], :course_id => params[:id]).first
    @student = Student.find(params[:student_id])
    @number = params[:number].nil? ? 3 : params[:number].to_i
    @student_actions = @enrollment.student_actions.where('date > ?', (Date.today - @number))
    @course = Course.find(params[:id])
  end
end
