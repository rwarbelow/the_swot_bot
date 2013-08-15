require 'spec_helper'

describe UserIdentity do
	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:password_digest) }
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }	
end
