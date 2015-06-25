class AuthController < ApplicationController

    def signin
        @user = User.new
    end

    def login
        user = User.find_by(login_email: app_params[:login_email])
        if user && user.authenticate(app_params[:login_email],app_params[:login_password])
            session[:user_id] = user.id
            session[:genre] = user.genre
            session[:role] = Role.find(user.role_id).role
            if session[:role]== 'mentor' || session[:role]== 'admin'
                redirect_to :applications, notice: "Logged in!"
            else
                redirect_to "/applications/new"
            end
        else
            @user = User.new
            flash.now[:error] = 'Unknown user. Please check your username and password.'
            render :action => "signin"
        end
    end
    def signout
        session[:user_id] = nil
        flash[:notice] = "You have been signed out."
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "Logged out!"
    end
    private 
    def app_params
        params.require(:user).permit(:login_email, :login_password)
    end

end

