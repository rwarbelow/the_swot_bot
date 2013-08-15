class Guardianship < ActiveRecord::Base
  validates :student_profile_id, :presence => true,  :uniqueness => { :scope => :guardian_profile_id }
  validates :guardian_profile_id, :presence => true, :uniqueness => { :scope => :student_profile_id }
  validates :relationship_to_student, :presence => true
  
  belongs_to :student_profile
  belongs_to :guardian_profile
end
