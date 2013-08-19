class CreateStudentActionCategories < ActiveRecord::Migration
	def change
		create_table :student_action_categories do |t|
			t.string :name

			t.timestamps
		end
	end
end
