class HomeController < ApplicationController

  def index
    @user = UserIdentity.new
  end
end
