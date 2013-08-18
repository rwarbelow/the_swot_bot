require 'spec_helper'

describe Submission do
  it { should validate_presence_of(:student_profile_id) }
  it { should validate_presence_of(:assignment_id) }
  it { should validate_presence_of(:score) }
 
  it { should belong_to(:assignment) }
  it { should belong_to(:student) }
end
	
