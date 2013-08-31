require 'spec_helper'

describe Admin do

	it { should have_one(:identity) }
end
