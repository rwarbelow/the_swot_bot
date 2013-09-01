class ScholarHour < ActiveRecord::Base
  attr_accessible :student_id, :reason, :date_assigned, :date_served

	validates :student_id, :presence => true
	validates :reason, :presence => true
	validate :set_date_assigned, :on => :create
	belongs_to :student


	def set_date_assigned
		self.date_assigned = Date.today
	end

end
