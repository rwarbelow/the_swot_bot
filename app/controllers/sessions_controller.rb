class SessionsController < ApplicationController
 
  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    @user = UserIdentity.new
  end

  def create
  	user = UserIdentity.where(:username => params[:user_identity][:username]).first
  	if user && user.authenticate(params[:user_identity][:password])
  		session[:user_id] = user.id
      session[:guardian_profile_id] = user.guardian_profile_id
      session[:teacher_profile_id] = user.teacher_profile_id
      session[:student_profile_id] = user.student_profile_id
  		flash[:notice] = "Successful Login!"
  	else
  		flash[:notice] = "Invalid Login... :("
    end
  	redirect_to root_url
  end
  
  def destroy
  	session.clear
  	flash[:notice] = "Logout Successful."
  	redirect_to root_url
  end
end
