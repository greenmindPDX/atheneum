class Comment < ActiveRecord::Base
	has_many :sub_comment, :class_name => "Comment", :foreign_key => "top_comment_id"
  	belongs_to :top_comment, :class_name => "Comment"
end