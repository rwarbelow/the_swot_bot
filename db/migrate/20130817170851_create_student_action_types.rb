class CreateStudentActionTypes < ActiveRecord::Migration
	def change
		create_table :student_action_types do |t|
			t.references :student_action_category
			t.string  :name
			t.string  :value

			t.timestamps
		end
	end
end
