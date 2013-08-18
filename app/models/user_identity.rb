class UserIdentity < ActiveRecord::Base
	attr_accessible :username, :password, :password_confirmation, :first_name, :last_name, :registration_code, :guardian_profile_id, :teacher_profile_id, :student_profile_id
  attr_accessor :registration_code, :session_user_type

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
	has_many 	 :sent_messages, :class_name => "Message", :foreign_key => "author_id" 
	has_many 	 :received_messages, :class_name => "Message", :foreign_key => "target_id" 

	before_validation :downcase_username
  
	delegate 	:gender, :birthday, :address, :ccsd_id, 
						:grade_level, :email, :registration_code, 
						:title, :preferred_language, 
						:to => :profile

	def profile
		if session_user_type == :TeacherProfile
			teacher_profile
		elsif session_user_type == :StudentProfile
			student_profile
		elsif session_user_type == :GuardianProfile
			guardian_profile
		else
			raise "WE'RE FUCKED"
		end
	end

	def student?
		!!student_profile_id
	end

	def teacher?
		!!teacher_profile_id
	end

	def guardian?
		!!guardian_profile_id
	end

	def has_one_profile?
		profiles = []
		profiles << self.teacher_profile
  	profiles << self.student_profile
  	profiles << self.guardian_profile

  	profiles.compact!
  	
  	profiles.length == 1 ? profiles.first : false
	end

	private

	def downcase_username
		self.username = self.username.downcase if self.username.present?
	end
end
