class StudentActionCategory < ActiveRecord::Base
  attr_accessible :name, :student_action_type_id
	validates :name, :presence => true

	has_many :student_action_types
end
