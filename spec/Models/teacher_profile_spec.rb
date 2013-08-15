require 'spec_helper'


describe TeacherProfile do
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:email) }
	# it { should validate_uniqueness_of(:email) }
	it { should validate_presence_of(:cell_phone_number) }
	# it { should validate_uniqueness_of(:cell_phone_number) }
end
