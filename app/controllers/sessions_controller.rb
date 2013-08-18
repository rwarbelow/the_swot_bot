class SessionsController < ApplicationController
 
  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    @user = UserIdentity.new
  end

  def create
  	@user = UserIdentity.where(:username => params[:user_identity][:username]).first
  	if @user && @user.authenticate(params[:user_identity][:password])
  		session[:user_id]   = @user.id

      if @user.student?
        redirect_to :student_homepage_path
      elsif @user.guardian?
        redirect_to :guardian_homepage_path
      elsif @user.teacher?
        redirect_to :teacher_homepage_path
      else
        raise RuntimeError, "User Identity #{@user.id} has no profile"
      end
      # # if user only has one profile, set it to that type, 
      # # else redirect to another screen to let user chooose
      # if user_profile = @user.has_one_profile?
      #   session[:session_user_type] = user_profile.class.to_s.to_sym
      # else
      #   # redirect_to choose_login_type_path
      # end
      
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
  	redirect_to login_path
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
