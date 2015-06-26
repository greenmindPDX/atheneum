class PdfWorker
    include Sidekiq::Worker
    # ref http://sidekiq.org/
    # run bundle exec sidekiq to start
    # needs to grab the id from the task, then convert that one thing to pdf, then update the active record to include the location of the document
    def perform(params)
        @params = params
  		app = Application.find(@params["application_id"])
  		#get fname lname of writing sample
  		if @params["doc_type"] == "letter"
  			@content = app.recommendation_letter
  		else
  			@content = "This is the writing sample: \n\n #{app.writing_sample}"
  		end
  		#1. create the PDF based on content
        generate_pdf 
  		# @todo move it to somewhere in the file system where public stuff is
    end

    def generate_pdf
        Prawn::Document.generate("lname_fname.pdf") do 
            text @content
        end
    end
end
