require 'spec_helper'

describe Course do
  it { should validate_presence_of(:teacher_id) }
  it { should validate_presence_of(:subject_id) }
  it { should validate_presence_of(:period) }

  it { should have_many(:enrollments) }
  it { should have_many(:students) }
  it { should have_many(:assignments) }

  it { should belong_to(:teacher) }
  it { should belong_to(:subject) }

  describe '#calculate_grade_for' do
    def calculate(percentage)
      Course.new.calculate_grade_for percentage
    end

    specify 'A for 90 upto infinity' do
      calculate(90).should == 'A'
      calculate(101).should == 'A'
    end

    specify 'B for 80 upto 90' do
      calculate(80).should == 'B'
      calculate(89.99).should == 'B'
    end

    specify 'C for 70 upto 80' do
      calculate(70).should == 'C'
      calculate(79.99).should == 'C'
    end

    specify 'D for 60 upto 70' do
      calculate(60).should == 'D'
      calculate(69.99).should == 'D'
    end

    specify 'F for 0  upto 60' do
      calculate(0).should == 'F'
      calculate(59.99).should == 'F'
    end

    specify 'blows up otherwise' do
      expect { calculate -1 }.to raise_error ArgumentError, /-1/
    end
  end
end
