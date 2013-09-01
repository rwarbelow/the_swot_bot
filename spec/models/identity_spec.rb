require 'spec_helper'

describe Identity do

	before do
		FactoryGirl.create(:identity)
	end

	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:password) }
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }
	it { should validate_uniqueness_of(:username) }

	it { should belong_to(:admin) }
	it { should belong_to(:teacher) }
	it { should belong_to(:student) }
	it { should belong_to(:guardian) }
	it { should have_many(:sent_messages) }
	it { should have_many(:received_messages) }
end
