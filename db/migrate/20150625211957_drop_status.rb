class DropStatus < ActiveRecord::Migration
  def change
	drop_table :statuses
	remove_column :applications, :status
	remove_column :applications, :status_id
  end
end
