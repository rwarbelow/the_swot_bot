class Students::BaseController < ApplicationController

	include StudentsHelper

  before_filter :require_student
end
