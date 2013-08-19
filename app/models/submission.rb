class Submission < ActiveRecord::Base
  attr_accessible :student_id, :assignment_id, :score

	validates :student_id, :presence => true
	validates :assignment_id, :presence => true
	validates :score, :presence => true

	belongs_to :assignment
	belongs_to :student  	 

  delegate :title, :description, :to => :assignment
end
