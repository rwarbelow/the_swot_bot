class IdentitiesController < ApplicationController

  def new
      @user = Identity.new
  end

  def create
    @user = Identity.new(params[:identity].merge({:guardian_id => session[:new_guardian_id],
     :student_id  => session[:new_student_id]}))
    if @user.save
      session.delete(:new_student_id)
      session.delete(:new_guardian_id)
      if current_teacher?
        flash[:success] = "Student #{@user.first_name} #{@user.last_name} successfully saved."
        redirect_to profile_path
      else
        session[:user_id] = @user.id
        redirect_to profile_path
      end
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
