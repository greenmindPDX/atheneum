class UsersController < ApplicationController

	def create
		@user = User.new(app_params)
    	if @user.save
        	session[:user_id] = @user.id
        	redirect_to root_url, notice: "Thank you for signing up!"
        	else
        	render "new"
    	end
	end

	def index
		@user = User.all
#		@users = User.new
	end

	def login
		@user = User.find
	end

	def new
		@user = User.create
	end

	private

    def app_params
         params.require(:user).permit(:login_email, :password, :first_name, :last_name)
    end
end