require 'spec_helper'

describe Guardianship do
  it { should validate_presence_of(:relationship_to_student) }
  it { should validate_presence_of(:student_profile_id) }
  it { should validate_presence_of(:guardian_profile_id) }

  it { should belong_to(:student) }
  it { should belong_to(:guardian) }

end
