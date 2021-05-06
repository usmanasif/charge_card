json.array! @transaction_lists do |transaction_list|
  json.partial! 'api/v1/transaction_lists/transaction_list', transaction_list: transaction_list
end
