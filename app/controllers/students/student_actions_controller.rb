class Students::StudentActionsController < Students::BaseController
  def new
  end

  def create
    render :json => "SUCCESS"
  end
end
