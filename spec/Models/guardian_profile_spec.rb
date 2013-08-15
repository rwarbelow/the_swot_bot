require 'spec_helper'

describe GuardianProfile do
  it { should validate_presence_of(:preferred_language) }
end
