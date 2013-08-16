class SessionsController < ApplicationController
 
  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    @user = UserIdentity.new
  end

  def create
  	user = UserIdentity.where(:username => params[:user_identity][:username]).first

  	if user && user.authenticate(params[:user_identity][:password])
  		session[:id] = user.id
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
