class CreateScholarHours < ActiveRecord::Migration
 	def change
		create_table :scholar_hours do |t|
			t.integer :student_id
			t.string :reason
			t.date :date_assigned
			t.date :date_served

			t.timestamps
		end
	end
end
