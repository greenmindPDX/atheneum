class CreateComment < ActiveRecord::Migration
	def change
		create_table :comments do |t|
			t.belongs_to :application, index:true
    		t.text :comment
			t.references :top_comment, index: true
    		t.timestamps
    	end
	end
end