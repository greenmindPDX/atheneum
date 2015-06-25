class ApplicationsController < ApplicationController

	def create
		@app = Application.new(app_params)
		@app.save
	end

	def index
		if session[:role] == "applicant"
			#@applications = Application.where_not(status:'archive').where(user_id: sessions[user_id])
		elsif session[:role] == "mentor"
	    	@applications = Application.where.not(status:'archive').where(genre: session[:genre]) #where status!=archive
		elsif session[:role] == 'admin'	
	    	@applications = Application.where.not(status:'archive') #where status!=archive
		end
	end

	def new
		@app = Application.new
	end

	def show
  		@app = Application.find_by(id: params[:id])
  		if @app.nil?
  			index
    		render "index" and return
		end
		render "show"
	end
	private

    def app_params
         params.require(:application).permit(:genre, :best_film, :writing_sample)
    end
end