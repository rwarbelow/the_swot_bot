class SessionsController < ApplicationController

  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    @user = UserIdentity.new
  end

  def create
  	@user = UserIdentity.where(:username => params[:user_identity][:username]).first
  	if @user && @user.authenticate(params[:user_identity][:password])
  		session[:user_id] = @user.id
      redirect_to profile_path
    else
      @user = UserIdentity.new
      flash[:errors] = "Invalid Login, sorry..."
      render 'sessions/new'
    end
  end

  def destroy
   session.clear
   flash[:notice] = "Logout Successful."
   redirect_to login_path
 end
end
