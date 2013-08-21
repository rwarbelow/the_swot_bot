class Teachers::EnrollmentsController < Teachers::BaseController

  def index
    @students = Student.all
  end

  def create
    errors = []
    @course = Course.find(params[:course_id])
    # consider using a nested model form -- google it
    params[:student_ids].each do |student_id|
      enrollment = Enrollment.create(:student_id => student_id, :course_id => @course.id)
      errors << "#{Student.find(student_id).first_name} #{Student.find(student_id).last_name} : #{enrollment.errors.full_messages.first}" unless enrollment.save
    end
    flash[:enrollment_errors] = errors
    redirect_to teachers_course_path(@course)
  end

end
