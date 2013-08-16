class Guardians::BaseController < ApplicationController
  before_filter :require_guardians # must be a teacher account
end
