class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  def profile_path
    if current_student?
      :students_root
    elsif current_guardian?
      :guardians_root
    elsif current_teacher?
      :teachers_root
    else
      raise RuntimeError, "User Identity #{@user.id} has no profile"
    end
  end

 def bad_actions
   bad_actions = ["calling-out",
                  "disrespecting-others",
                  "ignoring-instructions",
                  "laughing-at-others-mistakes",
                  "not-participating",
                  "side-conversations",
                  "sloppy-slant",
                  "swearing"]
  end

  def new_report(students, password = true)
  report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'swot_report.tlf')
    students.each do |student|
      courses = student.courses
      student_actions_array = []
      grade_array = []
      courses.each do |course|
        grade_array << course.enrollments.where(student_id:student.id).current_grade
        student_actions_array << course.enrollments.where(student_id:student.id).first.student_actions.current_week_report.group_by {|action| action.student_action_type.name}
      end
     report.start_new_page do |page|
        page.item(:student_name).value(student.full_name)
        page.item(:ccsd_id).value(student.ccsd_id)
        page.item(:start_date).value(start_date)
        page.item(:end_date).value(end_date)

        page.item(:class).value(courses[0].subject.name)
        page.item(:class1).value(courses[1].subject.name)
        page.item(:class2).value(courses[2].subject.name)
        page.item(:class3).value(courses[3].subject.name)
        page.item(:class4).value(courses[4].subject.name)
        page.item(:class5).value(courses[5].subject.name)



        student_actions_array.each do |array|
          n = 0
          array.each do |key,value|
            report.list("course#{n}").add_row do |row|
              row.item(:key).value(key) unless key == "missing-assignment"
              row.item(:val).value(value.count) unless key == "missing-assignment"
              row.item(:key).style(:color, 'red') if bad_actions.include?(key)
            end
          end
        end
      end
    end
    if password == true
      security_settings = {:user_password  => 'foo',
                           :owner_password => :random,
                              :permissions => { :print_document  => true,
                                                :modify_contents => false,
                                                :copy_contents   => true}}

      send_data report.generate(filename: 'swot_report.pdf',security: security_settings)
    else
      send_data report.generate(filename: 'swot_report.pdf')
    end
  end
end
