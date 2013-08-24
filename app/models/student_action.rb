class StudentAction < ActiveRecord::Base
  attr_accessible :enrollment_id, :student_action_type_id, :comment, :date

	validates :enrollment_id, :presence => true
	validates :date, 			 :presence => true
	validates :student_action_type_id, :presence => true
	belongs_to :enrollment
	belongs_to :student_action_type

  before_save :set_default_date

  # e.g.
  #  from = Date.parse '2013-01-01'
  #  to   = Date.parse '2014-01-01'
  #  (from...to).step(7) do |date|
  #    puts StudentAction.week_report date
  #  end
  def self.week_report(from=Date.current)
  	if from.friday?
      last_week_report()
    else
    	current_week_report()
    end
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
	def self.current_week_report(start_date = Date.commercial(Date.today.year, Date.today.cweek, 1), end_date = Date.commercial(Date.today.year, Date.today.cweek, 5))
		where("student_actions.created_at between ? and ?", start_date, end_date)
	end

  # rename -> previous_week
  def self.last_week_report(start_date = Date.commercial(Date.today.year, Date.today.cweek-1, 1), end_date = Date.commercial(Date.today.year, Date.today.cweek-1, 5))
  	where("student_actions.created_at between ? and ?", start_date, end_date)
  end

  def set_default_date
    self.date ||= Date.today if new_record?
  end
end
