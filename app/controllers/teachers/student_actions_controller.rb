class Teachers::StudentActionsController < Teachers::BaseController

  def index
    @courses = Course.where(:teacher_id => current_teacher.id)
  end

  def edit
    @student_action = StudentAction.find(params[:id])
  end

  def update
    @student_action = StudentAction.find(params[:id])
    if @student_action.update_attributes(params[:student_action])
      flash[:success] = "Action updated!"
      redirect_to teachers_livestream_path
    else
      flash[:action_errors] = @student_action.errors.full_messages
      render 'edit'
    end
  end

end
