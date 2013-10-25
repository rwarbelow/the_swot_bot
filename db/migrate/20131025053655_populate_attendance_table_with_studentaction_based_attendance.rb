class PopulateAttendanceTableWithStudentactionBasedAttendance < ActiveRecord::Migration
  def up
    say "Starting with #{start = Attendance.count} attendance records"
    ActiveRecord::Base.transaction do
      Attendance.skip_callback :save, :after, :submit_student_action
      category = StudentActionCategory.where(name: 'attendance').first
      category.student_action_types.each do |action_type|
        status_id = Attendance::STATUSES[Attendance::STUDENT_ACTION_STATUS_NAMES.rassoc(action_type.name).first]

        action_type.student_actions.each do |action|
          Attendance.create! enrollment_id: action.enrollment_id, status_id: status_id, date: action.date
        end
      end
      Attendance.set_callback :save, :after, :submit_student_action
    end
    say "Created #{Attendance.count - start} attendance records"
  end

  def down
    Attendance.destroy_all
  end
end
