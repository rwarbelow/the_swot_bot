class Enrollment < ActiveRecord::Base
  attr_accessible :student_id, :course_id
	validates :student_id, :presence => true
	validates :course_id, :presence => true
	validates :student_id, :uniqueness => { :scope => :course_id }

	belongs_to :course
	belongs_to :student
	has_many 	 :student_actions
end
