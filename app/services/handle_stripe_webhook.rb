class HandleStripeWebhook
  def initialize(logger)
    @logger = logger
  end

  def issuing_card_created(event)
    issue_card_create_or_update(event)
  end

  def issuing_card_updated(event)
    issue_card_create_or_update(event)
  end

  def issuing_authorization_created(event)
    transaction_list_create_or_update(event)
  end

  def issuing_authorization_updated(event)
    transaction_list_create_or_update(event)
  end

  private

    def issue_card_create_or_update(event)
      @card =  Card.find_or_initialize_by(issuing_card_id: event.data.object.id)
      @card.expiry_year =  event.data.object.exp_year
      @card.expiry_month =  event.data.object.exp_month
      @card.name = event.data.object.cardholder.name
      @card.last4 = event.data.object.last4
      @card.status = event.data.object.status
      @card.currency = event.data.object.currency
      @card.card_type = event.data.object.type

      @card.save
    end

    def transaction_list_create_or_update(event)
      card = Card.find_by(issuing_card_id: event.data.object.card.id)
      return if card.blank?

      @transaction_list = card.transaction_lists.find_or_initialize_by(authorization_id: event.data.object.id)
      @transaction_list.merchant_name =  event.data.object.merchant_data.name
      @transaction_list.merchant_category = event.data.object.merchant_data.category
      @transaction_list.amount = event.data.object.amount
      @transaction_list.approved = event.data.object.approved

      @transaction_list.save
    end
end
