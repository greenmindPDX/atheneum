class Application < ActiveRecord::Base
	include Statesman::Adapters::ActiveRecordQueries

	belongs_to :user
	has_many :terms, as: :termable
	has_many :application_transitions
	has_many :comments
	validates :genre, presence: true
	validates :status, presence: true

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

