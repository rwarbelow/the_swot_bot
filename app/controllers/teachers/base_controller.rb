class Teachers::BaseController < ApplicationController

	include TeacherHelper

  before_filter :require_teachers

end
