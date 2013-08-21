class Guardians::ReportsController < Guardians::BaseController
  def student_report
  	 @student = Student.where(:ccsd_id => params[:ccsd_id]).first
     @courses = @student.courses
     @student_actions_array = []
     @courses.each do |course|
       @student_actions_array << course.enrollments.where(student_id:@student.id).first.student_actions.week_report.group_by {|action| action.student_action_type.name}
  	 end
    render :layout => false
  end
end