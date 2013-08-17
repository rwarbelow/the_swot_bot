require 'spec_helper'

describe Message do
  it { should validate_presence_of(:author_id) }
  it { should validate_presence_of(:target_id) }
  it { should validate_presence_of(:body) }
 
  it { should belong_to(:author) }
  it { should belong_to(:target) }
end
