class CreateIdentities < ActiveRecord::Migration
	def change
		create_table :identities do |t|
			t.string   :username, :null => false
			t.string   :password_digest, :null => false
			t.string   :first_name, :null => false
			t.string   :last_name, :null => false
			t.integer  :student_id
			t.integer  :teacher_id
			t.integer  :guardian_id

			t.timestamps
		end
	end
end
