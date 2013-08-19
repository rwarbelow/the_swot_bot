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
end
