class UserIdentity < ActiveRecord::Base
	validates :username, 							:presence => true, :uniqueness => true
	validates :password, 							:presence => true
	validates :password_confirmation, :presence => true
	validates :first_name, 						:presence => true
	validates :last_name,  						:presence => true
	
  attr_accessor :registration_code

	has_secure_password

	has_many sent_invitations, :class_name => "Invitation", :foreign_key => 'sender_id'
	belongs_to :invitation
end
