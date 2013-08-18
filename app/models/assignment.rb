class Assignment < ActiveRecord::Base
	validates :course_id, :presence => true
	validates :title, :presence => true
	validates :description, :presence => true

	belongs_to :course
	has_many 	 :submissions
end
