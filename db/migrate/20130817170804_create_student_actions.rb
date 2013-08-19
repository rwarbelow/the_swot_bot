class CreateStudentActions < ActiveRecord::Migration
	def change
		create_table :student_actions do |t|
			t.references :enrollment
			t.references :student_action_type
			t.string	:comment
			t.date 		:date, :null => false
			
			t.timestamps
		end
	end
end
