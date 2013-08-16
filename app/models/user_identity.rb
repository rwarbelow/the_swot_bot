class UserIdentity < ActiveRecord::Base
	attr_accessible :username, :password, :password_confirmation, :first_name, :last_name
  attr_accessor :registration_code

	validates :username, 							    :presence => true, :uniqueness => true
	validates :password,                  :presence => { :on => :create }, :length => { :minimum => 6, :allow_blank => false }
	validates :first_name, 						    :presence => true
	validates :last_name,  						    :presence => true
	validates :teacher_profile_id, 			:uniqueness => true, :allow_nil => true  
	validates :student_profile_id, 			:uniqueness => true, :allow_nil => true
	validates :guardian_profile_id, 		:uniqueness => true, :allow_nil => true

	has_secure_password

	belongs_to :teacher_profile
	belongs_to :student_profile
	belongs_to :guardian_profile

	before_validation :downcase_username



	private

	def downcase_username
		self.username = self.username.downcase if self.username.present?
	end
end
