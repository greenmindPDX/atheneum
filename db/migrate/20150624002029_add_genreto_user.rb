class AddGenretoUser < ActiveRecord::Migration
  def change
		add_column :users, :genre, :string
  end
end
