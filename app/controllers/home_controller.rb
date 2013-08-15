class HomeController < ApplicationController

  skip_before_filter :user_auth

  def index
    @user = UserIdentity.new
  end
end
