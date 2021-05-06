json.extract! transaction_list, :id, :merchant_name, :amount, :card_id, :created_at
json.merchant_category transaction_list.merchant_category.titleize
json.status transaction_list.approved ? 'approved' : 'decline'
