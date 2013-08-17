require 'spec_helper'

describe Event do
  it { should validate_presence_of(:enrollment_id) }
  it { should validate_presence_of(:event_type_id) }
  it { should validate_presence_of(:date) }
 
  it { should belong_to(:enrollment) }
  it { should belong_to(:event_type) }

end
