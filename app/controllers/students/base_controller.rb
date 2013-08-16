class Students::BaseController < ApplicationController
  before_filter :require_students # must be a teacher account
end
