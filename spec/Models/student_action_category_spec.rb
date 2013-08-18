require 'spec_helper'

describe StudentActionCategory do
  it { should validate_presence_of(:name) }

  it { should have_many(:student_action_types) }
end
