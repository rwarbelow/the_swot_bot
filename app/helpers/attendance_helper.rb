module AttendanceHelper
  def attendance_class(attendance_value)
    'error' if attendance_value == 'absent'
  end

  def attendance_name(attendance)
    String(attendance)[0].to_s.upcase
  end
end
