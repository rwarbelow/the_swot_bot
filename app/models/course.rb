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

  def self.calculate_student_percent(categories_points_hash)
    @total_weight = 0
    @total_earned = 0
    categories_points_hash.each do |cat_points|
      @total_weight += cat_points[0][1]
      if cat_points[1][1] != 0
        category_percent = ((cat_points[1][0].to_f / cat_points[1][1].to_f) * cat_points[0][1]).round(4)
        @total_earned += category_percent
      end
    end
    if @total_weight != 0
      (@total_earned / @total_weight).round(3)
    else
      1
    end
  end

  def self.letter_grade(percent)
    case percent
    when 0.90...Float::INFINITY
      return "A"
    when 0.80...0.90
      return "B"
    when 0.70...0.80
      return "C"
    when 0.60...0.70
      return "D"
    when 0...0.60
      return "F"
    else
      return ""
    end
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
