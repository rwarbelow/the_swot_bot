class Course < ActiveRecord::Base
  attr_accessible :period, :teacher_id, :subject_id

	validates :teacher_id, :presence => true
	validates :period, :presence => true
	validates :subject_id, :presence => true
	validates :teacher_id, :uniqueness => { :scope => :period }

	has_many :assignments
	has_many :enrollments
	has_many :student_actions, :through => :enrollments
	has_many :students, :through => :enrollments
  has_many :assignment_categories
	belongs_to :teacher
	belongs_to :subject
  after_create :build_assignment_categories

  delegate :name, to: :subject, prefix: true, allow_nil: true

  def self.letter_grade(percent)
    case percent
    when 90...Float::INFINITY
      return "A"
    when 80...90
      return "B"
    when 70...80
      return "C"
    when 60...70
      return "D"
    when 0...60
      return "F"
    else
      return ""
    end
  end

  def assignment_category_names
    categories = ""
    self.assignment_categories.each do |ac|
      categories << ac.name + ": #{ac.weight*100}% "
    end
    categories
  end

  private

  def build_assignment_categories
    self.assignment_categories << AssignmentCategory.create(name: "test", weight: 0.20)
    self.assignment_categories << AssignmentCategory.create(name: "quiz", weight: 0.20)
    self.assignment_categories << AssignmentCategory.create(name: "classwork", weight: 0.20)
    self.assignment_categories << AssignmentCategory.create(name: "homework", weight: 0.20)
    self.assignment_categories << AssignmentCategory.create(name: "project", weight: 0.20)
  end

end
