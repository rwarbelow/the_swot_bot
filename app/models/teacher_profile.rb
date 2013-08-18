class TeacherProfile < ActiveRecord::Base
	include IdentityProfile

	attr_accessible :title, :email

	before_validation :downcase_email

	validates :title, :presence => true
	validates :email, :presence => true, :uniqueness => true

	has_many :phone_numbers, :as => :phone_numberable
	has_many :classes, :class_name => "Course"
	has_many :enrollments, :through => :classes
	has_many :students, :through => :enrollments, :class_name => "StudentProfile", :foreign_key => "student_profile_id"
	has_many :assignments, :through => :classes

	private

	def downcase_email
		self.email = self.email.downcase if self.email.present?
	end
end
