class Guardianship < ActiveRecord::Base
  attr_accessor :ccsd_id, :registration_code
  attr_accessible :student_profile_id, :guardian_profile_id, :relationship_to_student, :ccsd_id, :registration_code

  validates :student_profile_id, :presence => true,  :uniqueness => { :scope => :guardian_profile_id }
  validates :guardian_profile_id, :presence => true, :uniqueness => { :scope => :student_profile_id }
  validates :relationship_to_student, :presence => true
  
  belongs_to :student, :class_name => "StudentProfile", :foreign_key => "student_profile_id"
  belongs_to :guardian, :class_name => "GuardianProfile", :foreign_key => "guardian_profile_id"
end
