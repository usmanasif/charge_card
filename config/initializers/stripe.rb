Stripe.api_version = "2020-03-02"
Stripe.api_key             = ENV['STRIPE_SECRET_KEY']
StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']

TYPES = [
  {
    event_type: 'issuing_card.created',
    fun: 'issuing_card_created'
  },
  {
    event_type: 'issuing_card.updated',
    fun: 'issuing_card_updated'
  },
  {
    event_type: 'issuing_authorization.created',
    fun: 'issuing_authorization_created'
  },
  # {
  #   event_type: 'issuing_authorization.request',
  #   fun: 'subscription_updated'
  # },
  {
    event_type: 'issuing_authorization.updated',
    fun: 'issuing_authorization_updated'
  },
]

StripeEvent.configure do |events|
  TYPES.each do |type|
    events.subscribe type[:event_type] do |event|
      HandleStripeWebhook.new(Rails.logger).send(type[:fun], event)
    end
  end
end
