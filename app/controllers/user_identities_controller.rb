class UserIdentitiesController < ApplicationController

  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    if session[:guardian_profile_id] == nil
      redirect_to root_url
    else
      @user = UserIdentity.new
    end
  end

  def create
    @user = UserIdentity.new(params[:user_identity].merge({:guardian_profile_id => session[:guardian_profile_id],
     :student_profile_id  => session[:student_profile_id], 
     :teacher_profile_id  => session[:teacher_profile_id]}))
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
  
  private

  def profile_path
    if @user.teacher_profile_id != nil
      teacher_profile_path(@user.teacher_profile_id)
    elsif @user.guardian_profile_id != nil
      guardian_profile_path(@user.guardian_profile_id)
    elsif @user.student_profile_id != nil
      student_profile_path(@user.student_profile_id)
    else
      raise "Missing profile_id."
    end
  end
end
