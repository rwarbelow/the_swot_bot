require 'spec_helper'

describe GuardianProfile do
  it { should validate_presence_of(:preferred_language) }
  it { should have_many(:guardianships) }
  it { should have_many(:student_profiles) }
  it { should have_many(:phone_numbers) }
end
