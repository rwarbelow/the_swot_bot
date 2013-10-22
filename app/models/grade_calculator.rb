class GradeCalculator
  attr_reader :student, :course

  def initialize(options = {})
    @student = options[:student]
    @course = options[:course]
  end

  def grade
    (total_points / total_weight) * 100
  rescue ZeroDivisionError
    100
  end

  def total_points
    cumulative_scores_by_category.map do |categorized_grade|
      (categorized_grade.earned_points.to_f / categorized_grade.max_points.to_f) * categorized_grade.weight.to_f
    end.reduce(0, :+)
  end

  def total_weight
    cumulative_scores_by_category.map {|categorized_grade| categorized_grade.weight.to_f }.reduce(0, :+)
  end

  def cumulative_scores_by_category
    @cumulative_scores ||= Assignment.joins(:assignment_category, :submissions, :course)
      .select("assignment_categories.name category, assignment_categories.weight weight, SUM(assignments.maximum_points) max_points, SUM(submissions.points_earned) earned_points")
      .where(course_id: course.id, submissions: {student_id: student.id})
      .group("assignment_categories.name, assignment_categories.weight")
  end
end
