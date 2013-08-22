class Guardians::ReportsController < Guardians::BaseController
	def student_report
		@student = Student.where(:ccsd_id => params[:ccsd_id]).first

		render_student_report(@student)
	end


	private 

	def render_student_report(student)
		@courses = student.courses
		@student_actions_array = []
		@courses.each do |course|
			@student_actions_array << course.enrollments.where(student_id:student.id).first.student_actions.current_week_report.group_by {|action| action.student_action_type.name}
		end

		report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'tasks.tlf')
		report.start_new_page do |page|
			page.item(:student_name).value(student.first_name)	
			page.item(:ccsd_id).value(student.ccsd_id)
			page.item(:start_date).value(start_date)
			page.item(:end_date).value(end_date)

			page.item(:class).value(@courses[0].subject.name)
			page.item(:class1).value(@courses[1].subject.name)
			page.item(:class2).value(@courses[2].subject.name)
			page.item(:class3).value(@courses[3].subject.name)
			page.item(:class4).value(@courses[4].subject.name)
			page.item(:class5).value(@courses[5].subject.name)
			
			@student_actions_array[0].each do |key,value|
        report.list(:course).add_row do |row|
			    row.item(:key).value(key)
			    row.item(:val).value(value.count)
			  end
			end
			@student_actions_array[1].each do |key,value|
        report.list(:course1).add_row do |row|
			    row.item(:key).value(key)
			    row.item(:val).value(value.count)
			  end
			end
			@student_actions_array[2].each do |key,value|
        report.list(:course2).add_row do |row|
			    row.item(:key).value(key)
			    row.item(:val).value(value.count)
			  end
			end
			@student_actions_array[3].each do |key,value|
        report.list(:course3).add_row do |row|
			    row.item(:key).value(key)
			    row.item(:val).value(value.count)
			  end
			end
			@student_actions_array[4].each do |key,value|
        report.list(:course4).add_row do |row|
			    row.item(:key).value(key)
			    row.item(:val).value(value.count)
			  end
			end
			@student_actions_array[5].each do |key,value|
        report.list(:course5).add_row do |row|
			    row.item(:key).value(key)
			    row.item(:val).value(value.count)
			  end
			end

    security_settings = {
      :user_password  => 'foo',
      :owner_password => :random,
      :permissions => {
      :print_document  => true,
      :modify_contents => false,
      :copy_contents   => true
        }
      }

		send_data report.generate(filename: 'swot_report.pdf',security: security_settings)
	  end
  end
end
