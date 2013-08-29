class AssignmentCategory < ActiveRecord::Base
  attr_accessible :name, :weight
	validates :name, :presence => true
	validates :weight, :presence => true

	has_many :assignments
end
