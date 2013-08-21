class Inspiration < ActiveRecord::Base
  attr_accessible :body, :source

	validates :body, :presence => true
	validates :source, :presence => true

end
