class UserIdentitiesController < ApplicationController
  
  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    @user = UserIdentity.new
  end

  def create
    puts "*" * 80
    puts "in the UID controller"
    puts session[:guardian_profile_id]
    @user = UserIdentity.new(params[:user_identity])#, :guardian_profile_id => session[:guardian_profile_id],
                                                     #:student_profile_id  => session[:student_profile_id], 
                                                     #:teacher_profile_id  => session[:teacher_profile_id])
    @user.guardian_profile_id = session[:guardian_profile_id]
    @user.student_profile_id = session[:student_profile_id]
    @user.teacher_profile_id = session[:teacher_profile_id]
    session[:user_id] = @user.id
    if @user.save
      session[:user_id] = @user.id
      if @user.teacher_profile_id != nil
        redirect_to teacher_profile_path(@user.teacher_profile_id)
      elsif @user.guardian_profile_id != nil
        flash[:success] = "WOOO HOO I'm a guardian!"
        redirect_to guardian_profile_path(@user.guardian_profile_id)
      elsif @user.student_profile_id != nil
        redirect_to student_profile_path(@user.student_profile_id)
      else
        flash[:errors] = "You have not been assigned a teacher, student, or guardian id. Please see the system administrator."
        redirect_to user_identity_path(@user)
      end
      #redirect_to user_identity_path(@user)
    else
      @errors = @user.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end

  def edit
    @user = UserIdentity.find(params[:id])
  end

  def update
    if @user.update_attributes(params[:user_identity])
      flash[:success] = "Profile updated"
      redirect_to user_identity_path
    else
      @errors = @user.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
  end
end
