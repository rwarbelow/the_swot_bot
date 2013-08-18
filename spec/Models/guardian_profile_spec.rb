require 'spec_helper'

describe GuardianProfile do
  it { should validate_presence_of(:preferred_language) }
  
  it { should have_one(:user_identity) }
  it { should have_many(:guardianships) }
  it { should have_many(:students) }
  it { should have_many(:phone_numbers) }
end
