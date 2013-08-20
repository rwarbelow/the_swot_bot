class Assignment < ActiveRecord::Base
  attr_accessible :course_id, :title, :description

	validates :course_id, :presence => true
	validates :title, :presence => true
	validates :maximum_points, :presence => true
	validates :due_date, :presence => true

	belongs_to :course
	has_many 	 :submissions
end
