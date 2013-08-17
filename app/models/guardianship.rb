class Guardianship < ActiveRecord::Base
  attr_accessor :ccsd_id, :registration_code
  attr_accessible :student_profile_id, :guardian_profile_id, :relationship_to_student, :ccsd_id, :registration_code

  validates :student_profile_id, :presence => true,  :uniqueness => { :scope => :guardian_profile_id }
  validates :guardian_profile_id, :presence => true, :uniqueness => { :scope => :student_profile_id }
  validates :relationship_to_student, :presence => true
  
  belongs_to :student_profile
  belongs_to :guardian_profile
end
