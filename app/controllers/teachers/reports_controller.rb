class Teachers::ReportsController < Teachers::BaseController

  def report_search
  end

  def student_report
    students = Student.where(:ccsd_id => params[:ccsd_id])
    new_report(students, password = false)
  end

  def course
    students = Course.find(params[:course]).students
    new_report(students, password = false)
  end
end