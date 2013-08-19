class StudentAction < ActiveRecord::Base
  attr_accessible :enrollment_id, :student_action_type_id, :comment, :date

	validates :enrollment_id, :presence => true
	validates :date, 			 :presence => true
	validates :student_action_type_id, :presence => true

	belongs_to :enrollment
	belongs_to :student_action_type

  before_save :set_default_date

  def set_default_date
    self.date ||= Date.today if new_record?
  end
end
