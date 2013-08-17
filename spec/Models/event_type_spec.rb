require 'spec_helper'

describe EventType do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:event_category_id) }

  it { should have_many(:events) }
  it { should belong_to(:category) }
end
