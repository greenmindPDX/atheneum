class Term < ActiveRecord::Base
	belongs_to :termable, polymorphic: true
end