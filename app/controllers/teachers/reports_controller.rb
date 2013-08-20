class Teachers::ReportsController < Teachers::BaseController

  def report_search
  end

  def student_report
  	 @student = Student.first
     @courses = @student.courses
     @student_actions_array = []
     @courses.each do |course|
       @student_actions_array << course.enrollments.where(student_id:@student.id).first.student_actions.group_by {|action| action.student_action_type.name}
  	 end
    render :layout => false
  end

  def course
  	render :course, layout => false
  end
end