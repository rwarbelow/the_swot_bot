class EventCategory < ActiveRecord::Base
	validates :name, :presence => true

	has_many :event_types
end
