class CreateEventCategories < ActiveRecord::Migration
	def change
		create_table :event_categories do |t|
			t.references :event_type
			t.string :name

			t.timestamps
		end
	end
end
