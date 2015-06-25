class ApplicationTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :application, inverse_of: :application_transitions
end
