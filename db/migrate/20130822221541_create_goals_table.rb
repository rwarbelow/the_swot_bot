class CreateGoalsTable < ActiveRecord::Migration
  def change
		create_table :goals do |t|
			t.references :student
			t.string     :goal 
			t.string	   :status

			t.timestamps
		end
	end
end
