class Teachers::TeacherProfilesController < Teachers::BaseController

  skip_before_filter :user_auth

  def show
  end
end
