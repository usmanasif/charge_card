json.array! @transactions do |transaction|
  json.extract! transaction, :id, :merchant_name, :amount, :card_id, :created_at
  json.merchant_category transaction.merchant_category.titleize
end
