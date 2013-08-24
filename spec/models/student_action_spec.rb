require 'spec_helper'

describe StudentAction do
  it { should validate_presence_of(:enrollment_id) }
  it { should validate_presence_of(:student_action_type_id) }
  it { should validate_presence_of(:date) }
 
  it { should belong_to(:enrollment) }
  it { should belong_to(:student_action_type) }

end
