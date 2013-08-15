class UserIdentitiesController < ApplicationController
  
  skip_before_filter :user_auth, :only => [:new, :create]

  def new
    @user = UserIdentity.new
  end

  def create
    @user = UserIdentity.new(params[:user_identity])
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_identity_path(@user)
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
end
