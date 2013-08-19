class CreateSubmissions < ActiveRecord::Migration
	def change
		create_table :submissions do |t|
			t.references :student, :null => false
			t.references :assignment, :null => false
			t.integer    :score, :null => false, :default => 0

			t.datetime	:created_at
		end
	end
end

