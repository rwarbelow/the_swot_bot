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
	belongs_to :teacher
	belongs_to :subject


	def calculate_student_percentage(student)
    past_assignments = assignments.includes(:submissions).where('due_date < ?', Date.today).all
    return 100.0 if past_assignments.empty?
    total_points = earned_points = 0.0
    past_assignments.each do |assignment|
      student_submissions = assignment.submissions.select { |submission| submission.student_id == student.id }
      total_points += assignment.maximum_points
      student_submissions.each { |submission| earned_points += submission.points_earned  }
    end
    ((earned_points / total_points) * 100).round(1)
	end


	def calculate_student_grade(student)
    percentage = calculate_student_percentage(student)
    calculate_grade_for percentage
	end

  def calculate_grade_for(percentage)
    case percentage
    when 90...Float::INFINITY then "A"
    when 80...90              then "B"
    when 70...80              then "C"
    when 60...70              then "D"
    when  0...60              then "F"
    else
      raise ArgumentError, "Expected non-negative grade percentage, got #{percentage.inspect}"
    end
  end


end
