require 'spec_helper'

describe Enrollment do
  it { should validate_presence_of(:student_profile_id) }
  it { should validate_presence_of(:course_id) }

  it { should belong_to(:course) }
  it { should belong_to(:student) }

  it { should have_many(:events) }
end
