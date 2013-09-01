class Identity < ActiveRecord::Base
	attr_accessible :username, :password, :password_confirmation, :first_name, :last_name, :registration_code, :admin_id, :guardian_id, :teacher_id, :student_id
  attr_accessor :registration_code, :session_user_type

	validates :username, 							    :presence => true, :uniqueness => true
	validates :password,                  :presence => { :on => :create }, :length => { :minimum => 6, :allow_blank => false }
	validates :first_name, 						    :presence => true
	validates :last_name,  						    :presence => true
	validates :admin_id, 								  :uniqueness => true, :allow_nil => true
	validates :teacher_id, 								:uniqueness => true, :allow_nil => true
	validates :student_id, 								:uniqueness => true, :allow_nil => true
	validates :guardian_id, 							:uniqueness => true, :allow_nil => true

	has_secure_password

	belongs_to :admin
	belongs_to :teacher
	belongs_to :student
	belongs_to :guardian
	has_many 	 :sent_messages, :class_name => "Message", :foreign_key => "author_id"
	has_many 	 :received_messages, :class_name => "Message", :foreign_key => "target_id"

	before_validation :downcase_username

	delegate 	:gender, :birthday, :address, :ccsd_id,
						:grade_level, :email, :registration_code,
						:title, :preferred_language, :guardians,
						:to => :profile

	def profile
		if self.admin?
			admin
		elsif self.teacher?
			teacher
		elsif self.student?
			student
		elsif self.guardian?
			guardian
		else
			raise "No profile type"
		end
	end

	##custom validation for student? || teacher? || guardian?
	
	def admin?
		!!admin_id
	end

	def teacher?
		!!teacher_id
	end

	def student?
		!!student_id
	end

	def guardian?
		!!guardian_id
	end

	private

	def downcase_username
		self.username = self.username.downcase if self.username.present?
	end

	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
