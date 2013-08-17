class Subject < ActiveRecord::Base
	validates :name, :presence => true

	has_many :courses
end
