class StudentAction < ActiveRecord::Base
	validates :enrollment_id, :presence => true
	validates :student_action_type_id, :presence => true
	validates :date, 			 :presence => true
	validates :student_action_type_id, :uniqueness => { :scope => :enrollment_id }

	belongs_to :enrollment
	belongs_to :student_action_type
end
