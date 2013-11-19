require 'spec_helper'

describe GradeCalculator do
  before(:each) do
    @course = FactoryGirl.create :course
    @student = FactoryGirl.create :student, courses: [@course]
    @assignments = FactoryGirl.create_list(:assignment, 5, course: @course)
    @term = 2
    @assignments.each {|assignment| assignment.submissions.create student_id: @student.id}
  end

  it "grades by dividing the total points by the total weight times 100" do
    calculator = GradeCalculator.new(student: @student, course: @course)
    calculator.stub(:total_points).and_return(100)
    calculator.stub(:total_weight).and_return(50)
    calculator.grade.should eq(200)
  end

  it "calculates the total points across all categories" do
    calculator = GradeCalculator.new(student: @student, course: @course)
    calculator.stub(:cumulative_scores_by_category).and_return(
      [
        double('cumulative_grade', category: 'test',
              weight: 0.5, max_points: 200, earned_points: 150),
        double('cumulative_grade', category: 'test',
              weight: 0.5, max_points: 200, earned_points: 100)
      ]
    )
    calculator.grade.should eq(62.5)
  end

  it "can retrieve all cumulative scores for a student in a course" do
    gc = GradeCalculator.new(student: @student, course: @course)
    gc.cumulative_scores_by_category.each do |cumulative_score|
      cumulative_score.should respond_to :category
      cumulative_score.should respond_to :weight
      cumulative_score.should respond_to :max_points
      cumulative_score.should respond_to :earned_points
    end
  end

  it "gives the student a 100% if there are no assignments" do
    gc = GradeCalculator.new(student: @student, course: FactoryGirl.create(:course))
    gc.grade.should eq(100)
  end
end
