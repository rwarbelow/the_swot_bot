class Submission < ActiveRecord::Base
  attr_accessible :student_id, :assignment_id, :points_earned

	validates :student_id, :presence => true
	validates :assignment_id, :presence => true
	validates :points_earned, :presence => true

	belongs_to :assignment, dependent: :destroy
	belongs_to :student
  belongs_to :term

  delegate :title, :description, :to => :assignment

  def self.by_student(student_id)
  	where('student_id = ?', student_id)
  end

  def self.current
  	where(archived: false)
  end

  def self.archived
  	where(archived: true)
  end

  def self.by_term(term_id)
    where(term_id: term_id)
  end

end
