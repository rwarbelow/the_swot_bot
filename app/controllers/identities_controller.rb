class IdentitiesController < ApplicationController

  def new
    if session[:guardian_id] == nil
      redirect_to root_url
    else
      @user = Identity.new
    end
  end

  def create
    @user = Identity.new(params[:identity].merge({:guardian_id => session[:guardian_id],
     :student_id  => session[:student_id], 
     :teacher_id  => session[:teacher_id]}))
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      @errors = @user.errors.full_messages
      flash[:errors] = @errors
      render 'new'
    end
  end
  
  
  def edit
    @user = Identity.find(params[:id])
  end

  def update
    @user = Identity.find(params[:id])
    if @user.update_attributes(params[:identity])
      flash[:success] = "Profile updated"
      redirect_to profile_path
    else
      @errors = @user.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    Identity.find(params[:id]).destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
  end

end
