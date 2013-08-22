class Teachers::StudentActionsController < Teachers::BaseController

  def index
    @courses = Course.where(:teacher_id => current_teacher.id)
  end

  def edit
    @course = Course.find(params[:livestream_id])
    @student_action = StudentAction.find(params[:id])
  end

  def update
  end

end
