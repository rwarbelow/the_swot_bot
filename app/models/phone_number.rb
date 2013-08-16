class PhoneNumber < ActiveRecord::Base
	attr_accessible :number, :phone_numberable, :phone_numberabe_id, :phone_numberable_type

	belongs_to :phone_numberable, :polymorphic => true
end