class Students::StudentProfilesController < ApplicationController

  skip_before_filter :user_auth  

  def show
  end
end
