require 'spec_helper'


describe Student do
	before do
	  user = FactoryGirl.create(:student)
	end

	it { should validate_presence_of(:gender) }
	it { should validate_presence_of(:birthday) }
	it { should validate_presence_of(:ccsd_id) }
  it { should validate_uniqueness_of(:ccsd_id) }
	it { should validate_presence_of(:grade_level) }

	it { should have_one(:identity) }
	it { should have_many(:guardianships) }
	it { should have_many(:guardians) }
	it { should have_many(:teachers) }
	it { should have_many(:courses) }
	it { should have_many(:assignments) }
	it { should have_many(:submissions) }
	it { should have_many(:student_actions) }
	it { should have_many(:phone_numbers) }

end
