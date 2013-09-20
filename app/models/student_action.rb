class StudentAction < ActiveRecord::Base
  attr_accessible :enrollment_id, :student_action_type_id, :comment, :date

	validates :enrollment_id, :presence => true
	validates :date, 			 :presence => true
	validates :student_action_type_id, :presence => true
	belongs_to :enrollment
	belongs_to :student_action_type

  before_save :set_default_date
  after_create :update_bank_balance

  # e.g.
  #  from = Date.parse '2013-01-01'
  #  to   = Date.parse '2014-01-01'
  #  (from...to).step(7) do |date|
  #    puts StudentAction.week_report date
  #  end
  def self.week_report(from=Date.current)
  	if from.friday? || from.saturday? || from.sunday?
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

  # maybe something like this:
  # def self.for_week(n=0)
  #   week = Date.current.cweek + n
  #   year = Date.current.year
  #   while week < 0
  #     year -= 1
  #     week += 52
  #   end
  #   start_date = start_date = Date.commercial(year, week, 1)
  #   end_date   = start_date + 7
	# 	where("student_actions.created_at between ? and ?", start_date, end_date)
  # end
  #
  # would call with like StudentAction.by_week(-1).report
  # insetad of           StudentAction.previous_week.report

  # rename -> current_week
	def self.current_week_report(start_week = Date.commercial(Date.today.year, Date.today.cweek, 1), end_week = Date.commercial(Date.today.year, Date.today.cweek, 5))
		where("student_actions.created_at between ? and ?", start_week, end_week)
	end

  # rename -> previous_week
  def self.last_week_report(start_week = Date.commercial(Date.today.year, Date.today.cweek-1, 1), end_week = Date.commercial(Date.today.year, Date.today.cweek-1, 5))
  	where("student_actions.created_at between ? and ?", start_week, end_week)
  end

  def self.todays_actions
    where("student_actions.date = ?", Date.today)
  end

  def set_default_date
    self.date ||= Date.today if new_record?
  end
end
