require 'spec_helper'

describe Assignment do
  it { should validate_presence_of(:course_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
 
  it { should have_many(:submissions) }
  it { should belong_to(:course) }
end
	
