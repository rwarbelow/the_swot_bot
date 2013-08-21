class CreateAnnouncements < ActiveRecord::Migration
  def change
		create_table :announcements do |t|
			t.references :teacher
			t.string     :title 
			t.text	     :body
			t.date	     :expiration_date

			t.timestamps
		end
	end
end
