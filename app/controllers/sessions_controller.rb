class SessionsController < ApplicationController

  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    @user = Identity.new
  end

  def create
  	@user = Identity.where(:username => params[:identity][:username].downcase).first
  	if @user && @user.authenticate(params[:identity][:password])
  		session[:user_id] = @user.id
      session[:term_id] = 2
      @user.login_counter += 1
      @user.password = params[:identity][:password]
      @user.save
      dashboard
    else
      @user = Identity.new
      flash[:errors] = "Invalid Login, sorry..."
      render 'sessions/new'
    end
  end

  def destroy
   session.clear
   flash[:notice] = "Logout Successful."
   redirect_to login_path
 end

 def dashboard
    if current_user.student?
      redirect_to students_root_path
    elsif current_user.guardian?
      redirect_to guardians_root_path
    elsif current_user.teacher?
      redirect_to teachers_root_path
    else
      redirect_to login_path
    end
 end
end
