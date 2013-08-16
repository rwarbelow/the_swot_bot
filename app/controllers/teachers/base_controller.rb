class Teachers::BaseController < ApplicationController
  before_filter :require_teacher # must be a teacher account
end
