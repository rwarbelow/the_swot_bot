class Teachers::SubmissionsController < Teachers::BaseController

  def new
  end

  def create
    errors = []
    @assignment = Assignment.find(params[:assignment_id])
    ids_scores = params[:students].zip(params[:scores])
    p ids_scores # remove unnecessary debugging code/logging

    # consider a nested model form...
    ids_scores.each do |score|
      submission = Submission.find_or_create_by_assignment_id_and_student_id(@assignment.id, score[0])
      submission.points_earned = score[1]
      errors << "#{Student.find(score[0]).first_name} #{Student.find(score[0]).last_name} : #{submission.errors.full_messages.first}" unless submission.save
    end
    flash[:submission_errors] = errors
    redirect_to teachers_assignment_path(@assignment)
  end

end
