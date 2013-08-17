require 'spec_helper'

describe UserIdentity do

	before do
		FactoryGirl.create(:user_identity)
	end

	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:password) }
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }
	it { should validate_uniqueness_of(:username) }

	it { should belong_to(:teacher_profile) }
	it { should belong_to(:student_profile) }
	it { should belong_to(:guardian_profile) }
	it { should have_many(:sent_messages) }
	it { should have_many(:received_messages) }
end
