require 'spec_helper'

describe Reading do
  it { should validate_presence_of(:created_at) }

  it { should belong_to(:message) }
end
