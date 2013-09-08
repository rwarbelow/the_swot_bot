class Admin::DashboardController < Admin::BaseController
  def index
  	@new_scholar_hours = ScholarHour.where(date_assigned: Date.today, status: "Not Complete")
  end
end
