class Submission < ActiveRecord::Base
  attr_accessible :student_id, :assignment_id, :points_earned

	validates :student_id, :presence => true
	validates :assignment_id, :presence => true
	validates :points_earned, :presence => true

	belongs_to :assignment, dependent: :destroy
	belongs_to :student

  delegate :title, :description, :to => :assignment

  def self.by_student(student_id)
  	where('student_id = ?', student_id)
  end

  # add_index :submissions, :archived
  def self.current
  	where(archived: false)
  end

  def self.archived
  	where(archived: true)
  end
end
