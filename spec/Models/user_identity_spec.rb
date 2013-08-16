require 'spec_helper'

describe UserIdentity do
	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:password) }
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }
	it { should validate_uniqueness_of(:username) }
	it { should validate_uniqueness_of(:teacher_profile_id) }
	it { should validate_uniqueness_of(:student_profile_id) }
	it { should validate_uniqueness_of(:guardian_profile_id) }

	it { should belong_to(:teacher_profile) }
	it { should belong_to(:student_profile) }
	it { should belong_to(:guardian_profile) }
end