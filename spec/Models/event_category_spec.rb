require 'spec_helper'

describe EventCategory do
  it { should validate_presence_of(:name) }

  it { should have_many(:event_types) }
end
