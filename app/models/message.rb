class Message < ActiveRecord::Base
	validates :author_id, :presence => true
	validates :target_id, :presence => true
	validates :body, :presence => true

	belongs_to :author, :class_name => "Identity"
	belongs_to :target, :class_name => "Identity"
	has_one		 :reading
end
