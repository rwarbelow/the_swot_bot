class Teachers::BaseController < ApplicationController

  include TeachersHelper

  before_filter :require_teachers
  # before_filter :require_teacher # must be a teacher account
end
