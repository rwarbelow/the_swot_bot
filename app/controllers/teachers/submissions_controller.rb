class Teachers::SubmissionsController < Teachers::BaseController

  def new
  end

  def create
    errors = []
    @assignment = Assignment.find(params[:assignment_id])
    course = Course.find(@assignment.course_id)
    ids_scores = params[:students].zip(params[:scores])
    ids_scores.each do |score|
      student = Student.find(score[0])
      points = score[1]
      if score[1] != ""
        submission = Submission.find_or_create_by_assignment_id_and_student_id(@assignment.id, student.id)
        submission.points_earned = points
        submission.save
        enrollment = Enrollment.find_by_course_id_and_student_id(@assignment.course_id, student.id)
        enrollment.current_grade = student.grade_in(course)
        enrollment.save
        errors << "#{Student.find(score[0]).first_name} #{Student.find(score[0]).last_name} : #{submission.errors.full_messages.first}" unless submission.save
      end
    end
    if errors.length > 0
      flash[:submission_errors] = errors
      render 'teachers/assignments/show'
    else
      flash[:submission_errors] = errors
      redirect_to teachers_course_path(@assignment.course)
    end
  end

end
