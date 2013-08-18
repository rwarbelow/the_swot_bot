require 'spec_helper'

describe Course do
  it { should validate_presence_of(:teacher_profile_id) }
  it { should validate_presence_of(:subject_id) }
  it { should validate_presence_of(:period) }
 
  it { should have_many(:enrollments) }
  it { should have_many(:students) }
  it { should have_many(:assignments) }
 
  it { should belong_to(:teacher) }
  it { should belong_to(:subject) }
end
