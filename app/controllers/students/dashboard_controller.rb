class Students::DashboardController < Students::BaseController
  def index
  	@student = current_student
  	@inspiration = Inspiration.all.sample
  	@announcements = Announcement.all(:conditions => ["expiration_date >= ?", Date.today])
  end
end
