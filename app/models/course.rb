class Course < ActiveRecord::Base
	validates :teacher_profile_id, :presence => true
	validates :period, :presence => true 
	validates :subject_id, :presence => true 
	validates :teacher_profile_id, :uniqueness => { :scope => :period }

	has_many :assignments
	has_many :enrollments
	has_many :students, :through => :enrollments, :class_name => "StudentProfile", :foreign_key => "student_profile_id"
	belongs_to :teacher, :class_name => "TeacherProfile", :foreign_key => "teacher_profile_id"
	belongs_to :subject
end
