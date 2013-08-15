class TeacherProfile < ActiveRecord::Base
	before_validation :downcase_email
	
	validates :title, :presence => true
	validates :email, :presence => true, :uniqueness => true
	validates :cell_phone_number, :presence => true, :uniqueness => true 

	has_many :student_profiles_courses, through: :courses
	has_one :teacher_profile
	
	
	private

	def downcase_email
		self.email = self.email.downcase if self.email.present?
	end
end
