class SessionsController < ApplicationController
 
  def new
    @user = UserIdentity.new
  end

  def create
  	user = UserIdentity.find_by(:username => params[:user][:username])

  	if user && user.authenticate(params[:user][:password])
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
