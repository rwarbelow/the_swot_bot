class Students::GoalsController < Students::BaseController
  def create
    @student = current_student
    @goal = Goal.new(params[:goal])
    @student.goals << @goal
    if @goal.save
      redirect_to students_root_path
    else
      flash[:goal_errors] = @goal.errors.full_messages
      render "students/dashboard/index"
    end
  end

  def index
    @completed_goals = Goal.all.select{ |goal| goal.student_id == current_student.id && goal.status == "Complete"}
  end

  def edit
    @goal = Goal.find(params[:id])
    if current_student.id == @goal.student_id
      render 'edit'
    else
      redirect_to error_url
    end
  end

  def complete
    @goal = Goal.find(params[:goal_id])
    @goal.status = "Complete"
    @goal.save!
    redirect_to students_root_path
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(:goal => params[:goal][:goal])
      redirect_to students_root_path
    else
      flash[:goal_errors] = @student.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.delete
    redirect_to students_root_path
  end

end
