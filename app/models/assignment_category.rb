class AssignmentCategory < ActiveRecord::Base
  attr_accessible :name, :weight, :course_id
	validates :name, :presence => true
	validates :weight, :presence => true

	has_many :assignments
	has_many :submissions, :through => :assignments
	belongs_to :course

  def self.calculate_category_points(submissions_hash)
		@categories_hash = Hash.new([])
  	submissions_hash.each do |category|
  		@total_earned = 0
  		@total_worth = 0
  		category[1].each do |score_pair|
  			@total_earned += score_pair[0]
  			@total_worth += score_pair[1]
	  	end
	  	@categories_hash[category[0]] = [@total_earned, @total_worth]
	  end
	  @categories_hash
	end
 	
end
