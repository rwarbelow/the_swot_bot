class Goal < ActiveRecord::Base
  attr_accessible :goal, :student_id, :status

	validates :student_id, :presence => true
	validates :goal, :presence => true
	validate :set_default_status, :on => :create
	belongs_to :student


	def set_default_status
		self.status = "In Progress"
	end

end
