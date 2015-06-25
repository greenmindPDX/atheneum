class AddDefaultRoleIDtoUser < ActiveRecord::Migration
  def change
	remove_column :users, :login_password
  end
end
