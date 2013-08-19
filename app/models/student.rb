class Student < ActiveRecord::Base
	include IdentityProfile
	require 'SecureRandom'

	before_create :generate_registration_code

	attr_accessible :gender, :birthday, :address, :ccsd_id, :grade_level, :email, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code
  attr_accessor :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code

	validates :gender, :presence => true
	validates :birthday, :presence => true
	validates :ccsd_id, :presence => true, :uniqueness => true
	validates :grade_level, :presence => true
	# validates :registration_code, :presence => {:on => :create}

	has_one  :identity
	has_many :guardianships
	has_many :guardians, :through => :guardianships
	has_many :phone_numbers, :as => :phone_numberable
	has_many :enrollments
	has_many :courses, :through => :enrollments
	has_many :teachers, :through => :courses
	has_many :assignments, :through => :submissions
	has_many :submissions
	has_many :student_actions, :through => :enrollments
  
  protected

  def generate_registration_code
    self.registration_code = loop do
      random_token = SecureRandom.hex(4)
      break random_token unless Student.where(registration_code: random_token).exists?
    end
  end

  def enrolled_in? course
    courses.find(course.id)
  end

end
