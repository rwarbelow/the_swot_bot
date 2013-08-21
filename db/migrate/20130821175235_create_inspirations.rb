class CreateInspirations < ActiveRecord::Migration
	def change
		create_table :inspirations do |t|
			t.string :body
			t.string :source

			t.timestamps
		end
	end
end
