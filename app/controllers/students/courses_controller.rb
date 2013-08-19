class Students::CoursesController < Students::BaseController
  before_filter :load_course, :only => [:show]
  before_filter :enrolled_or_teaching, :only => [:show]
  before_filter :must_be_a_student, :only => [:index]

  def index
    @courses = current_student.courses
  end

  def show
  end

  private

  def must_be_a_student
     redirect_to root_path and return false unless current_student
  end

  def load_course
    @course = Course.find(params[:id])
  end

end
