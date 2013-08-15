class Role < ActiveRecord::Base
	validates :type, :presence => true
  belongs_to :user
end
