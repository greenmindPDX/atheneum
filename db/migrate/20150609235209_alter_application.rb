class AlterApplication < ActiveRecord::Migration
	add_reference :application_comments, :application
end
