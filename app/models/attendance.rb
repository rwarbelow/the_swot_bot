class Attendance < ActiveRecord::Base
  belongs_to :enrollment
  attr_accessible :date, :status_id, :enrollment_id

  STATUS_IDS = {
    1 => 'present',
    2 => 'tardy',
    3 => 'absent',
  }
  STATUSES = STATUS_IDS.each_with_object({}) {|(id, value), h| h[value] = id}
  STUDENT_ACTION_STATUS_NAMES = {
    'present' => 'on-time',
    'tardy'   => 'tardy',
    'absent'  => 'absent',
  }

  after_save :submit_student_action

  def self.save_for_student_ids(present_students, tardy_students, absent_students, course_id)
    [present_students, tardy_students, absent_students].each_with_index do |students, i|
      Enrollment.where(id: Array(students)).each do |enrollment|
        attendance = where(enrollment_id: enrollment.id, date: Date.today).first_or_create(status_id: i+1)
        attendance.status_id = i+1
        attendance.save if attendance.status_id_changed?
      end
    end
  end

  private 

  def submit_student_action
    student_action_type = StudentActionType.where(name: STUDENT_ACTION_STATUS_NAMES[STATUS_IDS[status_id]]).first
    StudentAction.where(date: Date.today, student_action_type_id: student_action_type.id, enrollment_id: enrollment_id).first_or_create
  end
end
