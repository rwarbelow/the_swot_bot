class Guardian < ActiveRecord::Base
	include IdentityProfile

	attr_accessor :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code, :registration_code, :ccsd_id, :relationship_to_student
  attr_accessible :address, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code, :email, :preferred_language, :registration_code, :ccsd_id, :relationship_to_student

	validates :preferred_language, :presence => true

	has_one  :identity
  has_many :guardianships
  has_many :students, :through => :guardianships
  has_many :phone_numbers, :as => :phone_numberable

  def self.valid_number?(phone_number)
    if PhoneNumber.find_by_number(phone_number) != nil
      true
    else
      false
    end
  end

  def textable_numbers
    phone_numbers.textable
  end
end
