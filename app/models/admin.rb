class Admin < ActiveRecord::Base
	include IdentityProfile

	has_one  :identity
end
