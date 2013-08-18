class Submission < ActiveRecord::Base
	validates :student_profile_id, :presence => true
	validates :assignment_id, :presence => true
	validates :score, :presence => true

	belongs_to :assignment
	belongs_to :student, :class_name => "StudentProfile", :foreign_key => "student_profile_id"  	 
end
