class Students::CoursesController < Students::BaseController
  before_filter :load_course, :only => [:show]
  before_filter :must_be_a_student, :only => [:index]

  def index
    @student = current_student
    @courses = current_student.courses
  end

  def show
    @course = Course.find(params[:id])
    enrollment = Enrollment.where(:student_id => current_student.id, :course_id => @course.id).first
    @student = current_student
    @enrollment = Enrollment.where(:student_id => current_student.id, :course_id => @course.id).first
    @assignments = @course.assignments.by_term(session[:term_id]).sort! { |a,b| a.due_date <=> b.due_date }
    @number = params[:number].nil? ? 20 : params[:number].to_i
    @student_actions = @enrollment.student_actions.where('date > ?', (Date.today - @number))
  end

  private

  def must_be_a_student
     redirect_to root_path and return false unless current_student
  end

  def load_course
    @course = Course.find(params[:id])
  end

end
