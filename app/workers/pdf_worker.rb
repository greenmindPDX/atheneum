class PdfWorker
	include Sidekiq::Worker
	# ref http://sidekiq.org/
	# needs to grab the id from the task, then convert that one thing to pdf, then update the active record to include the location of the document
  	def perform(name, count)
    		puts 'Doing hard work'
  	end
end
