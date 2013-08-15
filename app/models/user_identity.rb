class UserIdentity < ActiveRecord::Base
	validates :username, 							:presence => true, :uniqueness => true
	validates :password, 							:presence => true
	validates :password_confirmation, :presence => true
	validates :first_name, 						:presence => true
	validates :last_name,  						:presence => true
	
	has_secure_password
end
