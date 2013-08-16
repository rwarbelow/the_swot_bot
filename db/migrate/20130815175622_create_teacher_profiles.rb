class CreateTeacherProfiles < ActiveRecord::Migration
  def change
  	create_table :teacher_profiles do |t|
  		t.string :title, :null => false
  		t.string :email, :null => false
        		
  		t.timestamps
  	end
  end
end
