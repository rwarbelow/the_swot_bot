module IdentityProfile
	def self.included(includer)
    includer.class_eval do
			has_one	 :user_identity
			delegate :first_name, :last_name, :username, :to => :user_identity
		end
	end
end
