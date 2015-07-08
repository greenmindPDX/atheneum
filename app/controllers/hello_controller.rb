class HelloController < ApplicationController
	def index
		5.times do |msg|
			PrivatePub.publish_to "/messages/public", :chat_message => "Hello, world! #{msg}"
		end
	end
end