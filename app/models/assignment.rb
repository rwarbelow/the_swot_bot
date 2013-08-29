class Assignment < ActiveRecord::Base
  attr_accessible :course_id, :title, :description, :due_date, :maximum_points

	validates :course_id, :presence => true
	validates :title, :presence => true
	validates :maximum_points, :presence => true
	validates :due_date, :presence => true
	validates :category_id, :presence => true

	belongs_to :course
	belongs_to :assignment_category
	has_many 	 :submissions

def valid_date
  errors.add(:due_date, "Date must be for current school year") if due_date && due_date < Date.parse("2013-08-25")
end

def calculate_percent(earned)
	(earned.to_f / maximum_points.to_f) * 100
end

	def calculate_grade(earned)
		if calculate_percent(earned)
			case calculate_percent(earned)
			when 90..100
				return "A"
			when 80..89
				return "B"
			when 70..79
				return "C"
			when 60..69
				return "D"
			when 0..59
				return "F"
			else
				return ""
			end
		end
	end

end
