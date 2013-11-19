class Teachers::StudentProfilesController < Teachers::BaseController
  def show
    @student = Student.find(params[:id])
    @number = params[:number].nil? ? 3 : params[:number].to_i
    @student_actions = @student.student_actions.where('date >= ?', Date.today - @number)
    @incompleted_goals = Goal.all.select{ |goal| goal.student_id == @student.id && goal.status == "In Progress"}
    @completed_goals = Goal.all.select{ |goal| goal.student_id == @student.id && goal.status == "Complete"}
  end

  def edit
    @student = Student.find(params[:id])
    @user = @student.identity
    if @student && @student.id == current_user.student.id
      render 'students/students/edit'
    else
      redirect_to error_url
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:success] = "Profile updated"
      redirect_to student_path
    else
      @errors = @student.errors.full_messages
      render 'edit'
    end
  end

  def new
    @student = Student.new
  end

  def create
    birthday = "#{params[:student]['birthday(1i)']}-#{params[:student]['birthday(2i)']}-#{params[:student]['birthday(3i)']}"
    address = "#{params[:student][:address_line_1]} #{params[:student][:address_line_2]} #{params[:student][:address_city]} #{params[:student][:address_state]} #{params[:student][:address_zip_code]}"
    @student = Student.new(:gender => params[:student][:gender],
                           :birthday => birthday,
                           :address => address,
                           :ccsd_id => params[:student][:ccsd_id],
                           :grade_level => params[:student][:grade_level])
    if @student.save!
      session[:new_student_id] = @student.id
      redirect_to new_identity_path
    else
      @errors = @student.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end

  def index
    if current_user.student?
      redirect_to students_root_path
    elsif current_user.guardian?
      redirect_to guardians_root_path
    elsif current_user.teacher?
      if params[:sort]
        @students = Student.find(:all, :order => params[:sort])
        params[:sort].clear
      else
        @students = Student.all.sort! {|x, y| x.last_name <=> y.last_name}
      end
    else
      redirect_to login_path
    end
  end

  def course_overview
    @student = Student.find(params[:student_profile_id])
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments.by_term(session[:term_id]).sort! { |a,b| a.due_date <=> b.due_date }
    enrollment = Enrollment.where(:student_id => @student.id, :course_id => params[:course_id]).first
    @number = params[:number].nil? ? 1 : params[:number].to_i
    @student_actions = @student.student_actions.where('date > ?', (Date.today - @number))
  end
end
