class AddSaltToUser < ActiveRecord::Migration
  def change
  	add_column :applications, :recommender, :string
  	add_column :users, :password_hash, :string
  	add_column :users, :password_salt, :string
  end
end
