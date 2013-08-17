class EventType < ActiveRecord::Base
	validates :name, :presence => true
	validates :event_category_id, :presence => true
	validates :value, :presence => true

	has_many :events
	belongs_to :category, :class_name => "EventCategory", :foreign_key => "event_category_id"
end
