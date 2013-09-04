class ScholarHour < ActiveRecord::Base
	attr_accessible :student_id, :reason, :date_assigned, :date_served, :status

	validates :student_id, :presence => true
	validates :reason, :presence => true
	before_save :set_date_assigned, :on => :create
	before_save :set_default_status, :on => :create
	belongs_to :student


	def set_date_assigned
		self.date_assigned = Date.today unless self.date_assigned
	end

	def set_default_status
		self.status = "Not Complete" unless self.status
	end

	def self.find_daily_student_list
		@allstudents = Student.all
		@student_ids_scholar_hour = []
		@allstudents.each do |student|
			@student_actions_hash = student.collect_student_actions
			if student.negative(@student_actions_hash) >= 5 
				((student.negative(@student_actions_hash))/5).times do 
					@student_ids_scholar_hour << [student.id, "5 Deductions"]
				end
			end
			@num_missing = student.missing_assignments(@student_actions_hash)
			if @num_missing >= 1
				@student_ids_scholar_hour << [student.id, "#{@num_missing} Missing Assignment(s)"]
			end 
		end
		if @student_actions_hash[2] >= 1
			@student_ids_scholar_hour << [student.id, "Tardy"]
		end
		if @student_actions_hash[3] >= 1
			@student_ids_scholar_hour << [student.id, "Absent"]
		end
	end
	@student_ids_scholar_hour
end

