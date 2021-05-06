class TransactionList < ApplicationRecord
  scope :approved, -> { where(approved: true) }
end
