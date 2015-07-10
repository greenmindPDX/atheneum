class HisController < ApplicationController
	def index
		#send some json
		@applications = {"foo"=>"bar"}
		render json: @applications
  	end
end
