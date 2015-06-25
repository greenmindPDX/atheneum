class CreateApplicationComment < ActiveRecord::Migration
	def change
		create_table :application_comments do |t|
    		t.text :comment
    		t.timestamps
    end
  end
end
