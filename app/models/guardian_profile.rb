class GuardianProfile < ActiveRecord::Base
	include IdentityProfile

	attr_accessor :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code, :email, :preferred_language, :registration_code, :ccsd_id, :relationship_to_student
  attr_accessible :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code, :email, :preferred_language, :registration_code, :ccsd_id, :relationship_to_student

	validates :preferred_language, :presence => true

  has_many :guardianships
  has_many :student_profiles, through: :guardianships
  has_many :phone_numbers, :as => :phone_numberable
end
