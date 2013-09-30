class PhoneNumber < ActiveRecord::Base
	attr_accessible :number, :phone_numberable, :phone_numberable_id, :phone_numberable_type, :kind

	belongs_to :phone_numberable, :polymorphic => true

	before_save :strip_number

  scope :textable, -> { where(kind: 'cell') }

	def strip_number
		self.number.gsub!(/[^\d]/, '')
	end
end
