class StudentAction < ActiveRecord::Base
  attr_accessible :enrollment_id, :student_action_type_id, :comment, :date

	validates :enrollment_id, :presence => true
	validates :date, 			 :presence => true
	validates :student_action_type_id, :presence => true
	belongs_to :enrollment
	belongs_to :student_action_type

  before_save :set_default_date
  after_create :update_bank_balance

  def self.week_report(from=Date.current)
  	if from.thursday? || from.friday? || from.saturday? || from.sunday?
      current_week_report()
    else
    	last_week_report()
    end
  end

  def update_bank_balance
    student = self.enrollment.student
    student.bank_balance += self.student_action_type.value.to_i
    student.save
  end

	def self.current_week_report(start_week = Date.commercial(Date.today.year, Date.today.cweek, 1), end_week = Date.commercial(Date.today.year, Date.today.cweek, 6))
		where("student_actions.created_at between ? and ?", start_week, end_week)
	end

  # rename -> previous_week
  def self.last_week_report(start_week = Date.commercial(Date.today.year, Date.today.cweek-1, 1), end_week = Date.commercial(Date.today.year, Date.today.cweek-1, 6))
  	where("student_actions.created_at between ? and ?", start_week, end_week)
  end

  def self.todays_actions
    where("student_actions.date = ?", Date.today)
  end

  def set_default_date
    self.date ||= Date.today if new_record?
  end
end
