class Announcement < ActiveRecord::Base
  attr_accessible :course_id, :title, :description

	validates :teacher_id, :presence => true
	validates :title, :presence => true
	validates :body, :presence => true
	validates :expiration_date, :presence => true

	belongs_to :teacher
end
