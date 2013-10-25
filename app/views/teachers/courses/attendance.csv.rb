response.headers["Content-Disposition"] = 'attachment; filename=attendance.csv'

CSV.generate do |csv|
  csv << %w(Student) + @date_range.to_a
  @students.each do |student|
    attendances = student.attendance_in(@course, @date_range)
    csv << [student.full_name] + @date_range.map {|date| attendance_name(attendances[date]) }
  end
end
