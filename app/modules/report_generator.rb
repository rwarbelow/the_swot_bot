module ReportGenerator

       BAD_ACTIONS = ["baby-attack",
                      "causing-distractions",
                      "sloppy-work",
                      "calling-out",
                      "disrespecting-others",
                      "ignoring-instructions",
                      "laughing-at-others-mistakes",
                      "not-participating",
                      "side-conversations",
                      "sloppy-slant",
                      "swearing",
                      "tardy",
                      "incomplete-classwork",
                      "did-not-master-daily-goal",
                      "absent"]

  def new_report(students, password = true)
    report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'swot_report.tlf')
    students.each do |student|
      course_actions = generate_course_data(student)
      report.start_new_page do |page|
        page.item(:student_name).value(student.full_name)
        page.item(:ccsd_id).value("CCSD_ID: #{student.ccsd_id}")
        page.item(:date).value("#{start_date.strftime("%b. %e, %Y")} - #{end_date.strftime("%b. %e, %Y")}")
        page.item(:bank_balance).value("Bank Balance: $#{student.bank_balance}")

        course_actions.each_with_index do |course_data, index|
          page.item("grade#{index}").value("#{course_data[:grade]}% #{course_data[:letter_grade]}")
          page.item("mw#{index}").value(course_data[:missing_work])
          page.item("class#{index}").value(course_data[:course].subject.name)
          course_data[:actions].each do |action_name, actions|
            unless action_name == "missing-assignment"
              report.list("course#{index}").add_row do |row|
                if BAD_ACTIONS.include?(action_name)
                  row.item(:key).value("- #{action_name}")
                  row.item(:val).value(actions.count)
                else
                  row.item(:key).value("+ #{action_name}")
                  row.item(:val).value(actions.count)
                end
                row.item(:key).style(:color, 'red') if BAD_ACTIONS.include?(action_name)
              end
            end
          end
        end
        @security_settings = {:user_password  => student.ccsd_id,
                              :owner_password => :random,
                              :permissions => { :print_document  => true,
                                                :modify_contents => false,
                                                :copy_contents   => true}}
      end
    end
    if password == true
      send_data report.generate(filename: 'swot_report.pdf',security: @security_settings)
    else
      send_data report.generate(filename: 'swot_report.pdf')
    end
  end


  def generate_course_data(student)
    courses = student.courses
    course_actions = []
    courses.each do |course|
    missing_work_array = []
      grade = student.grade_in(course, session[:term_id])
      letter_grade = Course.letter_grade(grade)
      actions = course.enrollments.where(student_id:student.id).first.student_actions.week_report.group_by {|action| action.student_action_type.name}
      course.enrollments.where(student_id:student.id).first.student_actions.week_report.each do |action|
        missing_work_array << action if action.student_action_type.name == "missing-assignment"
      end
      course_actions << {course: course, actions: actions, grade: grade, missing_work: missing_work_array.length, letter_grade: letter_grade}
    end
    course_actions
  end
end
