class Students::CoursesController < Students::BaseController
  before_filter :load_course, :only => [:show]
  before_filter :must_be_a_student, :only => [:index]

  def index
    @student = current_student
    @courses = current_student.courses
  end

  def show
    @assignments = Assignment.current.where(:course_id => params[:id]).sort! { |a,b| a.due_date <=> b.due_date }
    enrollment = Enrollment.where(:student_id => current_student.id, :course_id => params[:id]).first
    @student_actions = current_student.student_actions.where('date > ?', (Date.today - 20))  
    @student = current_student
  end
  private

  def must_be_a_student
     redirect_to root_path and return false unless current_student
  end

  def load_course
    @course = Course.find(params[:id])
  end

end
