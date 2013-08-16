class Guardians::BaseController < ApplicationController

  include GuardianHelper

  before_filter :require_guardians
end
