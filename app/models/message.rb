class Message < ActiveRecord::Base
	attr_accessor :to
	attr_accessible :author_id, :target_id, :body, :subject

	validates :author_id, :presence => true
	validates :target_id, :presence => true
	validates :body, :presence => true
	validates :subject, :presence => true

	belongs_to :author, :class_name => "Identity"
	belongs_to :target, :class_name => "Identity"
	has_one		 :reading
end
