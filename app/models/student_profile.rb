class StudentProfile < ActiveRecord::Base
	include IdentityProfile
	require 'SecureRandom'

	before_create :generate_registration_code

	attr_accessible :gender, :birthday, :address, :ccsd_id, :grade_level, :email

	validates :gender, :presence => true
	validates :birthday, :presence => true
	validates :ccsd_id, :presence => true, :uniqueness => true
	validates :grade_level, :presence => true
	# validates :registration_code, :presence => {:on => :create}

	has_one  :user_identity
	has_many :guardianships
	has_many :guardians, :through => :guardianships, :class_name => "GuardianProfile", :foreign_key => "guardian_profile_id"
	has_many :phone_numbers, :as => :phone_numberable
	has_many :enrollments
	has_many :classes, :through => :enrollments, :class_name => "Course", :foreign_key => "course_id"
	has_many :teachers, :through => :classes, :class_name => "TeacherProfile", :foreign_key => "teacher_profile_id"
	has_many :assignments, :through => :submissions
	has_many :submissions
	has_many :actions, :through => :enrollments, :class_name => "StudentActions"
  attr_accessible :gender, :birthday, :ccsd_id, :grade_level

  protected

  def generate_registration_code
    self.registration_code = loop do
      random_token = SecureRandom.hex(4)
      break random_token unless StudentProfile.where(registration_code: random_token).exists?
    end
  end

end
