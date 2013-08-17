class CreateEvents < ActiveRecord::Migration
	def change
		create_table :events do |t|
			t.references :enrollment
			t.references :event_type
			t.string	:comment
			t.date 		:date, :null => false, :default => Date.today
			
			t.timestamps
		end
	end
end
