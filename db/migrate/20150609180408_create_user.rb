class CreateUser < ActiveRecord::Migration
	def change
    	create_table :users do |t|
    		t.string :first_name
    		t.string :last_name
   		 	t.string :login_email
   		 	t.string :login_password #bcrypt or something
   		 	t.timestamps
   	 	end
	end
			add_reference :applications, :user
end
