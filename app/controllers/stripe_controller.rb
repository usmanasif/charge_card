class StripeController < ApplicationController
  def webhook
    StripeEvent.instrument(verified_event)
  end

  private

    def verified_event
      payload          = request.body.read
      signature        = request.headers['Stripe-Signature']
      possible_secrets = secrets(payload, signature)

      possible_secrets.each_with_index do |secret, i|
        begin
          return Stripe::Webhook.construct_event(payload, signature, secret.to_s)
        rescue Stripe::SignatureVerificationError
          raise if i == possible_secrets.length - 1
          next
        end
      end
    end

    def secrets(payload, signature)
      return StripeEvent.signing_secrets if StripeEvent.signing_secret
      raise Stripe::SignatureVerificationError.new(
              "Cannot verify signature without a `StripeEvent.signing_secret`",
              signature, http_body: payload)
    end
end
