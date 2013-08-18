class Reading < ActiveRecord::Base
	validates :created_at, :presence => true

	belongs_to :message
end
