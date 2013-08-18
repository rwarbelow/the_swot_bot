class Students::StudentActionsController < Students::BaseController
  def new

  end

  def create
    p "<<<<<<<<<<<<<<<<<<<<<<<<\n"
    p params
    render :json => "SUCCESS"
  end
end