class Application < ActiveRecord::Base
	include Statesman::Adapters::ActiveRecordQueries

	belongs_to :user
	has_many :terms, as: :termable
	has_many :application_transitions
	has_many :comments
	validates :genre, presence: true
	#only complete if the writing sample is here and the reference has a path, 
	#meaning the letter of rec is uploaded
	#todo move to a concern
	def is_complete?
		app = Application.find(self.id)
		if app.writing_sample && app.location_reference
			true
		else
			false
		end
	end

	def generate_letter
		params = {}
		if printable_recommendation?
			params["application_id"] = self.id
			params["doc_type"] = "letter"
			params["content"] = self.recommendation_letter			
			#PdfWorker.perform_async(params)
		end
	end

	def generate_sample
		params = {}
		if printable_sample?
			params["application_id"] = self.id
			params["doc_type"] = "sample"
			PdfWorker.perform_async(params)
		end
	end


	def printable_recommendation?
		true unless self.recommendation_letter.blank?
	end

	def printable_sample?
		true unless self.writing_sample.blank?
	end

  	def state_machine
    	@state_machine ||= ApplicationStateMachine.new(self, transition_class: ApplicationTransition)
  	end

	def self.initial_state
    	:pending
  	end
  	def self.transition_class
    	ApplicationTransition
  	end

end

# Possible status
# pending (the application has begun
# completed (the application is complete): writing sample, uploaded letter of rec, 
# invited (we are inviting them to join)
# rejected (we don’t like them)
# declined
# accepted (student has accepted application)
# withdrawn (student paid, then fled)
# archived (don't display)
=begin
 state transitions

	
=end

