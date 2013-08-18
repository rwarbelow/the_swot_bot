class Students::BaseController < ApplicationController

  def enrolled_or_teaching
    return true if current_student? and current_student.enrolled_in?(@course)
    return true if current_teacher? and current_teacher.teaching?(@course)

    redirect_to root_path and return false
  end
end
