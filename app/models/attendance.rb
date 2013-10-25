class Attendance < ActiveRecord::Base
  belongs_to :enrollment
  attr_accessible :date, :status_id, :enrollment_id

  STATUS_IDS = {
    1 => 'present',
    2 => 'tardy',
    3 => 'absent',
  }
  STATUSES = STATUS_IDS.each_with_object({}) {|(id, value), h| h[value] = id}
end
