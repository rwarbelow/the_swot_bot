class Enrollment < ActiveRecord::Base
  attr_accessible :student_id, :course_id
	validates :student_id, :presence => true
	validates :course_id, :presence => true
	validates :student_id, :uniqueness => { :scope => :course_id }
	validate  :period_uniqueness

	belongs_to :course
	belongs_to :student
	has_many 	 :student_actions

	def period_uniqueness
		return unless self.course_id
		period = course.period
		student_courses.each do |course|
			if period == course.period
				errors.add(:course_id, "Students can only be enrolled in one course per period")
			end
		end
	end

	def student_courses
		student.courses
	end 

end
