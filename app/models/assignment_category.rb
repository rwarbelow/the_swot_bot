class AssignmentCategory < ActiveRecord::Base
  attr_accessible :name, :weight, :course_id
	validates :name, :presence => true
	validates :weight, :presence => true

	has_many :assignments
	has_many :submissions, :through => :assignments
	belongs_to :course
end
