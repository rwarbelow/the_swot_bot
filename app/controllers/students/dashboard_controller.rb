class Students::DashboardController < Students::BaseController
  def index
  	@inspiration = Inspiration.all.sample
  end
end
