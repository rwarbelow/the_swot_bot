class StudentProfile < ActiveRecord::Base
	validates :gender, :presence => true
	validates :birthday, :presence => true
	validates :ccsd_id, :presence => true, :uniqueness => true
	validates :grade_level, :presence => true

	belongs_to :student_role
	has_many :student_guardian_relationships
	has_many :parent_profiles, through: :student_guardian_relationships
	has_many :student_profile_courses
	has_many :courses, through: :student_profile_courses
end
