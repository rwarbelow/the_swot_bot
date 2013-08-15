class GuardianProfile < ActiveRecord::Base
	validates :preferred_language, :presence => true

  belongs_to :guardian_role
  has_many :guardianships
  has_many :student_profiles, through: :guardianships
end
