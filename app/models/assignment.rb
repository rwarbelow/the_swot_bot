class Assignment < ActiveRecord::Base
  attr_accessible :course_id, :title, :description, :due_date, :maximum_points, :assignment_category_id

	validates :course_id, :presence => true
	validates :title, :presence => true
	validates :maximum_points, :presence => true
	validates :due_date, :presence => true
	validates :assignment_category_id, :presence => true

	belongs_to :course
	belongs_to :assignment_category
	has_many 	 :submissions

	def valid_date
	  errors.add(:due_date, "Date must be for current school year") if due_date && due_date < Date.parse("2013-08-25")
	end

	def calculate_percent(earned)
		(earned.to_f / maximum_points.to_f)
	end

	def calculate_grade(earned)
		if calculate_percent(earned)
			case calculate_percent(earned)
			when 0.90..1
				return "A"
			when 0.80..0.899
				return "B"
			when 0.70..0.799
				return "C"
			when 0.60..0.699
				return "D"
			when 0..0.599
				return "F"
			else
				return ""
			end
		end
	end
	
end
