require 'spec_helper'

describe Role do
	it { should validate_presence_of(:type) }
end
