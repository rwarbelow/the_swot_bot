require 'spec_helper'


describe StudentProfile do
	before do
	  user = FactoryGirl.create(:student_profile)
	end

	it { should validate_presence_of(:gender) }
	it { should validate_presence_of(:birthday) }
	it { should validate_presence_of(:ccsd_id) }
  it { should validate_uniqueness_of(:ccsd_id) }
	it { should validate_presence_of(:grade_level) }

	it { should have_one(:user_identity) }
	it { should have_many(:guardianships) }
	it { should have_many(:guardian_profiles) }
	it { should have_many(:teachers) }
	it { should have_many(:classes) }
	it { should have_many(:assignments) }
	it { should have_many(:submissions) }
	it { should have_many(:actions) }
	it { should have_many(:phone_numbers) }

end
