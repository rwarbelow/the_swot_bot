class Teachers::TeacherProfilesController < Teachers::BaseController

  skip_before_filter :user_auth
  skip_before_filter :require_teachers, :only => [:new, :create]

  def show
  end
end
