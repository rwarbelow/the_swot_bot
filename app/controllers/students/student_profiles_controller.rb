class Students::StudentProfilesController < Students::BaseController

  skip_before_filter :user_auth
  skip_before_filter :require_students, :only => [:new, :create]

  def show
  end
end
