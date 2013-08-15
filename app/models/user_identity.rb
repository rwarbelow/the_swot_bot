class UserIdentity < ActiveRecord::Base

	validates :username, 							:presence => true, :uniqueness => true
	validates :password, 							:presence => true
	validates :password_confirmation, :presence => true
	validates :first_name, 						:presence => true
	validates :last_name,  						:presence => true
	
	attr_accessible :username, :password, :password_confirmation, :first_name, :last_name
  attr_accessor :registration_code

	has_secure_password

	has_many :roles
	has_secure_password

	before_validation :downcase_username

	private

	def downcase_username
		self.username = self.username.downcase if self.username.present?
	end
end
