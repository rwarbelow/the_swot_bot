class CreateReadings < ActiveRecord::Migration
 	def change
		create_table :readings do |t|
			t.references :message

			t.datetime	:created_at
		end
	end
end
