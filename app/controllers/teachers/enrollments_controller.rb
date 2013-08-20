class Teachers::EnrollmentsController < Teachers::BaseController

  def index
    @students = Student.all
  end
end
