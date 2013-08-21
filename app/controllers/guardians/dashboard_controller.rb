class Guardians::DashboardController < Guardians::BaseController
  def index
    @announcements = Announcement.all(:conditions => ["expiration_date >= ?", Date.today])
  end
end
