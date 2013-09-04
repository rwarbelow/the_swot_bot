class Teachers::EnrollmentsController < Teachers::BaseController

  def index
    @course = Course.find(params[:course_id])
    @enrolled_students = @course.students
    @not_enrolled_students = Student.all - @enrolled_students
  end

  def create
    errors = []
    @course = current_teacher.courses.find(params[:course_id])
    params[:student_ids].each do |student_id|
      enrollment = Enrollment.create(:student_id => student_id, :course_id => @course.id)
      errors << "#{Student.find(student_id).first_name} #{Student.find(student_id).last_name} : #{enrollment.errors.full_messages.first}" unless enrollment.save
    end
    flash[:enrollment_errors] = errors
    redirect_to teachers_course_roster_path(@course)
  end

  def destroy
    course = Course.find(params[:course_id])
    @enrollment = Enrollment.find(params[:id])
    flash[:success_message] = "#{@enrollment.student.first_name} #{@enrollment.student.last_name} removed from #{course.subject.name}, period #{course.period}."
    @enrollment.destroy
    redirect_to teachers_course_roster_path(course)
  end

end
