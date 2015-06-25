class AddStatustoAppplication < ActiveRecord::Migration
	def change
  		change_column :applications, :status, :string, default: 'pending'
	end
end
