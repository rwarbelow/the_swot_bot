class Assignment < ActiveRecord::Base
  attr_accessible :course_id, :title, :description, :due_date

	validates :course_id, :presence => true
	validates :title, :presence => true
	validates :maximum_points, :presence => true
	validates :due_date, :presence => true
  validate :valid_date

	belongs_to :course
	has_many 	 :submissions

def valid_date
  errors.add(:due_date, "date cannot be before 8-25-13") if due_date && due_date < Date.parse("2013-08-25")
end

end
