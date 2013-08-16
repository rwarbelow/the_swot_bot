class StudentProfile < ActiveRecord::Base
	include IdentityProfile

	validates :gender, :presence => true
	validates :birthday, :presence => true
	validates :ccsd_id, :presence => true, :uniqueness => true
	validates :grade_level, :presence => true

	has_many :guardianships
	has_many :guardian_profiles, :through => :guardianships
	has_many :phone_numbers, :as => :phone_numberable

  attr_accessible :gender, :birthday, :ccsd_id, :grade_level
end
