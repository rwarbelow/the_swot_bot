class UserIdentitiesController < ActionController::Base
  
  def new
    @user = UserIdentity.new
  end

  def create
    user = UserIdentity.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      @errors = user.errors.full_messages
      flash[:errors] = @errors
      redirect_to root_url
    end
  end

  def show
  end
end
