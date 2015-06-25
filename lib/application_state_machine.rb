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
# pending (the application has begun
# completed (the application is complete): writing sample, uploaded letter of rec, 
# invited (we are inviting them to join)
# rejected (we don’t like them)
# declined
# accepted (student has accepted invitation)
# matriculted (paid)
# withdrawn (student paid, then fled)
# archived (don't display)

  transition from: :pending,      to: [:completed, :archived]
  transition from: :completed,    to: [:invited, :rejected]
  transition from: :invited,      to: [:declined, :accepted, :archived]
  transition from: :rejected,     to: [:pending, :archived]
  transition from: :declined,     to: [:pending, :archived]
  transition from: :accepted,     to: [:matriculated, :withdrawn, :archived]
  transition from: :withdrawn,    to: [:pending, :archived]
  transition from: :matriculated, to: :archived
  transition from: :archived,     to: :pending

  guard_transition(to: :checking_out) do |order|
    order.products_in_stock?
  end

  before_transition(from: :checking_out, to: :cancelled) do |order, transition|
    order.reallocate_stock
  end

  before_transition(to: :purchased) do |order, transition|
    PaymentService.new(order).submit
  end
# send an email inviting this person.
  after_transition(to: :invited) do |order, transition|
    MailerService.invitation(order).deliver
  end
end
