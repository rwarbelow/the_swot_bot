class Term < ActiveRecord::Base
  attr_accessible :name, :start_date, :end_date

	validates :name, :presence => true
	validates :start_date, :presence => true
	validates :end_date, :presence => true

	has_many :assignments
	has_many :submissions
end
