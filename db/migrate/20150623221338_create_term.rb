class CreateTerm < ActiveRecord::Migration
	def change
		create_table :terms do |t|
    		t.text :term
    		t.boolean :active
			t.references :termable, polymorphic: true, index: true
    		t.timestamps
    	end
	end
end
