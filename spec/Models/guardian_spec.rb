require 'spec_helper'

describe Guardian do
  it { should validate_presence_of(:preferred_language) }
  
  it { should have_one(:identity) }
  it { should have_many(:guardianships) }
  it { should have_many(:students) }
  it { should have_many(:phone_numbers) }
end
