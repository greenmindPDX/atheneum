#######################
# State Machine Class #
#######################
class ApplicationStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :completed
  state :invited
  state :rejected
  state :declined
  state :accepted
  state :withdrawn
  state :matriculated
  state :archived
# note a problem with Statesman: https://github.com/gocardless/statesman/issues/153
# you have to create the initializer with ActiveRecord storage adaptor in config/initializers
#
# then run rails g statesman:active_record_transition Application ApplicationTransition


  transition from: :pending,      to: [:completed, :archived]
  transition from: :completed,    to: [:invited, :rejected]
  transition from: :invited,      to: [:declined, :accepted, :archived]
  transition from: :rejected,     to: [:pending, :archived]
  transition from: :declined,     to: [:pending, :archived]
  transition from: :accepted,     to: [:matriculated, :withdrawn, :archived]
  transition from: :withdrawn,    to: [:pending, :archived]
  transition from: :matriculated, to: :archived
  transition from: :archived,     to: :pending

  #guard_transition(to: :checking_out) do |order|
  #  order.products_in_stock?
  #end
  guard_transition(to: :completed) do |application|
      application.is_complete?
  end

#  before_transition(from: :checking_out, to: :cancelled) do |order, transition|
#    order.reallocate_stock
#  end

#  before_transition(to: :purchased) do |order, transition|
#    PaymentService.new(order).submit
#  end
# send an email inviting this person.
  after_transition(to: :invited) do |application,transition|
    MailerService.invitation(appication).deliver
  end
# possible states
# pending (the application has begun
# completed (the application is complete): writing sample, uploaded letter of rec, 
# invited (we are inviting them to join)
# rejected (we don’t like them)
# declined
# accepted (student has accepted invitation)
# matriculted (paid)
# withdrawn (student paid, then fled)
# archived (don't display)

end
