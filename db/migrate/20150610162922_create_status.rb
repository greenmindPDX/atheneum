class CreateStatus < ActiveRecord::Migration
	def change
		create_table :statuses do |t|
			t.string :app_status
		end
	end
	add_reference :applications, :status
end