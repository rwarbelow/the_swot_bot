class TeacherProfile < ActiveRecord::Base
	include IdentityProfile

	before_validation :downcase_email
	
	validates :title, :presence => true
	validates :email, :presence => true, :uniqueness => true
	validates :cell_phone_number, :presence => true, :uniqueness => true 

	has_many :phone_numbers, :as => :phone_numberable	
	
	private

	def downcase_email
		self.email = self.email.downcase if self.email.present?
	end
end
