require 'spec_helper'

describe Announcement do
  it { should validate_presence_of(:teacher_id) }
  it { should validate_presence_of(:title ) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:expiration_date) }
 
  it { should belong_to(:teacher) }
end
