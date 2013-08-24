require 'spec_helper'

describe Submission do
  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:assignment_id) }
  it { should validate_presence_of(:points_earned) }
 
  it { should belong_to(:assignment) }
  it { should belong_to(:student) }
end
	
