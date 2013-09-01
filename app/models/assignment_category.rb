class AssignmentCategory < ActiveRecord::Base
  attr_accessible :name, :weight, :course_id
	validates :name, :presence => true
	validates :weight, :presence => true

	has_many :assignments
	has_many :submissions, :through => :assignments
	belongs_to :course


 	def worth(student)
 		@worth = 0
 		if submissions.where('student_id = ?', student.id).length > 0
	 		submissions.where('student_id = ?', student.id).each do |submission|
	 			@worth += (submission.assignment.maximum_points.to_f) if submission.assignment.due_date < Date.today
 		end
 		end
 		@worth
 	end

 	def earned(student)
 		@earned = 0
 		if submissions.where('student_id = ?', student.id).length > 0
	 		submissions.where('student_id = ?', student.id).each do |submission|
	 			@earned += (submission.points_earned.to_f) if submission.assignment.due_date < Date.today
	 		end
	 	end
 		@earned
 	end

 	def total(student)
 		(earned(student) / worth(student)) * weight
 	end

end
