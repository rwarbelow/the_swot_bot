class CreateAssignments < ActiveRecord::Migration
 	def change
		create_table :assignments do |t|
			t.references :course
			t.string :title 
			t.text	 :description

			t.datetime	:created_at
		end
	end
end
