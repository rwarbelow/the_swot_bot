require 'spec_helper'

describe StudentActionType do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:student_action_category_id) }

  it { should have_many(:student_actions) }
  it { should belong_to(:category) }
end
