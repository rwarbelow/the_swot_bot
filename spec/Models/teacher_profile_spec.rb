require 'spec_helper'

describe TeacherProfile do

	before do
		FactoryGirl.create(:teacher_profile)
	end

	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }

	it { should have_many(:courses) }
	it { should have_many(:phone_numbers) }
end
