class Teachers::LivestreamController < Teachers::BaseController

  def index
    @courses = Course.where(:teacher_id => current_teacher.id)
  end

end
