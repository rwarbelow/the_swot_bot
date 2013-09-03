class Admin::TeacherProfilesController < Admin::BaseController
  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      session[:teacher_id] = @teacher.id
      redirect_to new_identity_path
    else
      @errors = @teacher.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
    @user = @teacher.identity
    render 'teachers/profiles/edit'
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update_attributes(params[:teacher])
      flash[:success] = "Profile updated"
      redirect_to admin_teacher_profile_path(@teacher)
    else
      @errors = @teacher.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
    @teacher = Teacher.find(params[:id])
  end
  
end
