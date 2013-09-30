class Student < ActiveRecord::Base
	include IdentityProfile

	before_create :generate_registration_code

	attr_accessible :gender, :birthday, :address, :ccsd_id, :grade_level, :email, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code, :bank_balance
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
	has_many :scholar_hours

	def collect_student_actions
		@student_actions_array = []
		self.student_actions.todays_actions.each do |action|
			@student_actions_array << action.student_action_type_id
		end
		aggregate_student_behavior_hash(@student_actions_array)
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

  def self.import(file)
    CSV.foreach(file.path,headers:true) do |row|
    hash = row.to_hash
    student = Student.create!(
      :gender => hash["gender"],
      :birthday => hash["birthday"],
      :ccsd_id => hash["ccsd_id"],
      :grade_level => hash["grade_level"])

    student.build_identity(
      :password => 'password',
      :first_name => hash["first_name"],
      :last_name => hash["last_name"],
      :username => "#{hash["first_name"]}#{hash["last_name"]}")
    student.save
    end
  end

  def calculate_percent(course)
  	course_category_submissions = self.find_submissions(course)
  	categories_hash = AssignmentCategory.calculate_category_points(course_category_submissions)
  	percent = Course.calculate_student_percent(categories_hash)
  	(percent * 100).round(1)
  end

  def find_submissions(course)
  	@course_category_submissions = Hash.new([])
  	@course_submissions = []
  	self.submissions.each do |submission|
  		@course_submissions << submission if submission.assignment.course_id == course.id
  	end
  	@course_submissions.each do |submission|
  		cat = "#{submission.assignment.assignment_category.name}"
  		weight = submission.assignment.assignment_category.weight
  		@course_category_submissions[[cat, weight]] = []
  	end
  	self.submissions.each do |submission|
  		cat = "#{submission.assignment.assignment_category.name}"
  		weight = submission.assignment.assignment_category.weight
  	  @course_category_submissions[[cat, weight]] << [submission.points_earned, submission.assignment.maximum_points] if submission.assignment.course_id == course.id
  	end
  	@course_category_submissions
  end

  def full_name
  	"#{last_name}, #{first_name}"
  end

  def textable_guardians?
  	guardians.map {|g| g.textable_numbers.count }.reduce(:+) > 0
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
