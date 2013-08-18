class StudentActionCategory < ActiveRecord::Base
	validates :name, :presence => true

	has_many :student_action_types
end
