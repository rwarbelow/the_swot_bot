class Guardians::CoursesController < Guardians::BaseController
  def show
    @assignments = Assignment.where(:course_id => params[:id])
    enrollment = Enrollment.where(:student_id => params[:student_id], :course_id => params[:id]).first
    @actions = StudentAction.where(:enrollment_id => enrollment.id).sort! { |a, b| b.id <=> a.id }
  end
end
