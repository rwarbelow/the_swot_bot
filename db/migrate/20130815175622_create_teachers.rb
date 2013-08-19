class CreateTeachers < ActiveRecord::Migration
  def change
  	create_table :teachers do |t|
  		t.string :title, :null => false
  		t.string :email, :null => false
        		
  		t.timestamps
  	end
  end
end
