class Course < ActiveRecord::Base
  attr_accessible :period, :teacher_id, :subject_id

	validates :teacher_id, :presence => true
	validates :period, :presence => true 
	validates :subject_id, :presence => true 
	validates :teacher_id, :uniqueness => { :scope => :period }

	has_many :assignments
	has_many :enrollments
	has_many :students, :through => :enrollments
	belongs_to :teacher
	belongs_to :subject


	def calculate_student_percentage(student)
		if self.assignments.length == 0
			return ""
		else
			@total_points = 0
			@earned_points = 0
			self.assignments.each do |assignment|
				if assignment.due_date <= Date.today + 1
					student_submissions = assignment.submissions.where(:student_id => student.id)
					@total_points += assignment.maximum_points
					@earned_points += student_submissions.first.points_earned if student_submissions.length > 0
				end
			end
			if @earned_points && @total_points
				earned = @earned_points.to_f
				total = @total_points.to_f
				return ((earned / total) * 100).round(1)
			end
		end
	end


	def calculate_student_grade(student)
		if calculate_student_percentage(student)
			case calculate_student_percentage(student)
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
