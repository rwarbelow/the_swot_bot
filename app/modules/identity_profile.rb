module IdentityProfile
	def self.included(includer)
    includer.class_eval do
			has_one	 :identity
			delegate :first_name, :last_name, :full_name, :username, :to => :identity
		end
	end
end
