class CreateEventTypes < ActiveRecord::Migration
	def change
		create_table :event_types do |t|
			t.references :event_category
			t.string  :name
			t.string  :value

			t.timestamps
		end
	end
end
