class AddWritingSampletoApplication < ActiveRecord::Migration
	def change
		add_column :applications, :writing_sample, :text
	end
end
