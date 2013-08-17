class Event < ActiveRecord::Base
	validates :enrollment_id, :presence => true
	validates :event_type_id, :presence => true
	validates :date, 			 :presence => true
	validates :event_type_id, :uniqueness => { :scope => :enrollment_id }

	belongs_to :enrollment
	belongs_to :event_type
end
