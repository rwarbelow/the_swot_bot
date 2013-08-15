require 'spec_helper'

describe StudentProfile do
	it { should validate_presence_of(:gender) }
	it { should validate_presence_of(:birthday) }
	it { should validate_presence_of(:ccsd_id) }
	# it { should validate_uniqueness_of(:ccsd_id) }
	it { should validate_presence_of(:grade_level) }	
end
