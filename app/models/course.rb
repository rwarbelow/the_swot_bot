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

  def calculate_student_percentage(student)
    if assignment_categories.select { |category| category.submissions.length == 0 }.length == 5
      return 1
    else
      @total_earned = 0
      @total_worth = 0
      active_categories = assignment_categories.select { |category| category.weight > 0 }.select { |category| category.submissions.length > 0 }
      active_categories.each do |category|
        @total_earned += category.earned(student)
        @total_worth += category.worth(student)
      end
      (@total_earned.to_f / @total_worth.to_f).round(2)
    end
  end

	def calculate_student_grade(student)
    percentage = calculate_student_percentage(student)
    calculate_grade_for(percentage)
	end

  def calculate_grade_for(percentage)
    case percentage
    when 0.90...Float::INFINITY   then "A"
    when 0.80...0.90              then "B"
    when 0.70...0.80              then "C"
    when 0.60...0.70              then "D"
    when 0...0.60                 then "F"
    else
      raise ArgumentError, "Expected non-negative grade percentage, got #{percentage.inspect}"
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
