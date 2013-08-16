class GuardianProfile < ActiveRecord::Base
	include IdentityProfile
	
	validates :preferred_language, :presence => true

  has_many :guardianships
  has_many :student_profiles, through: :guardianships
  has_many :phone_numbers, :as => :phone_numberable
end
