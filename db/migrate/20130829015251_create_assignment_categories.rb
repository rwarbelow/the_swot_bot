class CreateAssignmentCategories < ActiveRecord::Migration
	def change
		create_table :assignment_categories do |t|
			t.string :name
			t.float :weight
			t.integer :course_id

			t.timestamps
		end
	end
end
