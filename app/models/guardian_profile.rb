class GuardianProfile < ActiveRecord::Base
	include IdentityProfile

	attr_accessor :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code, :email, :preferred_language, :registration_code, :registration_code1, :registration_code2, :registration_code3, :ccsd_id, :relationship_to_student
  attr_accessible :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code, :email, :preferred_language, :registration_code, :registration_code1, :registration_code2, :registration_code3, :ccsd_id, :relationship_to_student

	validates :preferred_language, :presence => true

	has_one  :user_identity
  has_many :guardianships
  has_many :students, :through => :guardianships, :class_name => "StudentProfile", :foreign_key => "student_profile_id"
  has_many :phone_numbers, :as => :phone_numberable
end
