class HomeController < ApplicationController

  def index
    @user = Identity.new
  end
end
