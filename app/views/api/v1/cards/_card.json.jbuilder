json.extract! card, :id, :name, :last4, :expiry_month, :expiry_year, :status, :currency, :card_type
json.balance_owed card.transaction_lists.approved.sum(:amount)

