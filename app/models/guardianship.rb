class Guardianship < ActiveRecord::Base
  attr_accessor :ccsd_id, :registration_code
  attr_accessible :student_id, :guardian_id, :relationship_to_student, :ccsd_id, :registration_code

  validates :student_id, :presence => true,  :uniqueness => { :scope => :guardian_id }
  validates :guardian_id, :presence => true, :uniqueness => { :scope => :student_id }
  validates :relationship_to_student, :presence => true
  
  belongs_to :student
  belongs_to :guardian
end
