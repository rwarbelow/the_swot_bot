class Submission < ActiveRecord::Base
  attr_accessible :student_profile_id, :assignment_id, :score

	validates :student_profile_id, :presence => true
	validates :assignment_id, :presence => true
	validates :score, :presence => true

	belongs_to :assignment
	belongs_to :student_profile  	 

  delegate :title, :description, :to => :assignment
end
