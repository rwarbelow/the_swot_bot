class Guardians::BaseController < ApplicationController

  include GuardiansHelper

  before_filter :require_guardians
end
