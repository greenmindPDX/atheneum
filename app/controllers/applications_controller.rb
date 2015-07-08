class ApplicationsController < ApplicationController

	def create
		@app = Application.new(app_params)
		@app.save
	end

	# todo filter by existence of state machine
	# 
	def index
		if session[:role] == "applicant"
			@applications = Application.where(user_id: sessions[user_id]).reject{ |r| r.state_machine.current_state=='archived'}
		elsif session[:role] == "mentor"
			@applications = Application.where(genre:'fiction').reject{ |r| r.state_machine.current_state=='archived'}
		elsif session[:role] == 'admin'	
	    	@applications = Application.all.reject{ |r| r.state_machine.current_state=='archived'} #where status!=archive
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