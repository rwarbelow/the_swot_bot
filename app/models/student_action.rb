class StudentAction < ActiveRecord::Base
  attr_accessible :enrollment_id, :student_action_type_id, :comment, :date

	validates :enrollment_id, :presence => true
	validates :date, 			 :presence => true
	validates :student_action_type_id, :presence => true
	belongs_to :enrollment
	belongs_to :student_action_type

  before_save :set_default_date

  def self.week_report
  	if Time.now.wday != 5
      last_week_report
    else
    	current_week_report
    end
  end

	def self.current_week_report(start_date = Date.commercial(Date.today.year, Date.today.cweek, 1), end_date = Date.commercial(Date.today.year, Date.today.cweek, 5))
		where("student_actions.created_at between ? and ?", start_date, end_date)
	end

  def self.last_week_report(start_date = Date.commercial(Date.today.year, Date.today.cweek-1, 1), end_date = Date.commercial(Date.today.year, Date.today.cweek-1, 5))
  	where("student_actions.created_at between ? and ?", start_date, end_date)
  end

  def set_default_date
    self.date ||= Date.today if new_record?
  end
end
