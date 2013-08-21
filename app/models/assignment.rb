class Assignment < ActiveRecord::Base
  attr_accessible :course_id, :title, :description, :due_date, :maximum_points

	validates :course_id, :presence => true
	validates :title, :presence => true
	validates :maximum_points, :presence => true
	validates :due_date, :presence => true
  # validate :valid_date

	belongs_to :course
	has_many 	 :submissions

  def valid_date
    errors.add(:due_date, "Date must be for current school year") if due_date && due_date < Date.parse("2013-08-25") # if this date is going to be hardcoded, please move it to a constantc alled SCHOOL_YEAR_START_DATE so its clear what this value is
  end

end
