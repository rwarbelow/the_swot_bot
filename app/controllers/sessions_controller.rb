class SessionsController < ApplicationController
 
  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    @user = UserIdentity.new
  end

  def create
  	@user = UserIdentity.where(:username => params[:user_identity][:username]).first
  	if @user && @user.authenticate(params[:user_identity][:password])
  		session[:user_id] = @user.id
      session[:guardian_profile_id] = @user.guardian_profile_id
      session[:teacher_profile_id] = @user.teacher_profile_id
      session[:student_profile_id] = @user.student_profile_id
  		flash[:notice] = "Successful Login!"
      redirect_to profile_path
  	else
      @user = UserIdentity.new
  		flash[:errors] = "Invalid Login... :("
      render 'sessions/new'
    end
  end
  
  def destroy
  	session.clear
  	flash[:notice] = "Logout Successful."
  	redirect_to root_url
  end

  def profile_path
    if @user.teacher_profile_id != nil
      teacher_profile_path(@user.teacher_profile_id)
    elsif @user.guardian_profile_id != nil
      guardian_profile_path(@user.guardian_profile_id)
    elsif @user.student_profile_id != nil
      student_profile_path(@user.student_profile_id)
    else
      raise "Missing profile_id"
    end
  end
end
