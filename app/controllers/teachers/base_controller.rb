class Teachers::BaseController < ApplicationController

  include TeachersHelper

  before_filter :require_teachers
end
