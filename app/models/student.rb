class Student < ActiveRecord::Base
	include IdentityProfile

	before_create :generate_registration_code

	attr_accessible :gender, :birthday, :address, :ccsd_id, :grade_level, :email, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code
  attr_accessor :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code

	validates :gender, :presence => true
	validates :birthday, :presence => true
	validates :ccsd_id, :presence => true, :uniqueness => true
	validates :grade_level, :presence => true
	# validates :registration_code, :presence => {:on => :create}

	has_one  :identity
	has_many :guardianships
	has_many :guardians, :through => :guardianships
	has_many :phone_numbers, :as => :phone_numberable
	has_many :enrollments
	has_many :courses, :through => :enrollments
	has_many :teachers, :through => :courses
	has_many :submissions
	has_many :student_actions, :through => :enrollments
	has_many :goals

	def collect_student_actions
		student_actions_array = []
		self.student_actions.select {|action| action.date == Date.today}.each do |action|
			student_actions_array << action.student_action_type_id
		end
		aggregate_student_behavior_hash(student_actions_array)
	end

	def aggregate_student_behavior_hash(student_actions_array) 
		@student_actions_hash = Hash.new(0)
		student_actions_array.each do |n|
			@student_actions_hash[n] +=1
		end
		@student_actions_hash
	end

	def positive(student_actions_hash)
		positive_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category_id == 2 && student_action_type.value == "1"
				positive_score += no_of_occurances
			end
		end
		return positive_score
	end

	def negative(student_actions_hash)
		negative_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category_id == 2 && student_action_type.value == "-1"
				negative_score += no_of_occurances
			end
		end
		return negative_score
	end

	def missing_assignments(student_actions_hash)
		missing_assignments_score = 0
		student_actions_hash.each do |student_action_type_id, no_of_occurances|
			student_action_type = StudentActionType.find(student_action_type_id)
			if student_action_type.student_action_category_id == 4
				missing_assignments_score += no_of_occurances
			end
		end
		return missing_assignments_score
	end
  
  protected

  def generate_registration_code
  	self.registration_code = loop do
  		possible = (('A'..'Z').to_a + (0..9).to_a + ('a'..'z').to_a)
  		random_token = (0...6).map { |n| possible.sample }.join
  		break random_token unless Student.where(registration_code: random_token).exists?
  	end
  end

  def enrolled_in? course
    courses.find(course.id)
  end

end
