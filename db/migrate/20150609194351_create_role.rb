class CreateRole < ActiveRecord::Migration
	def change
		create_table :roles do |t|
			t.string :role
    	end
	end
	add_reference :users,:role
end

