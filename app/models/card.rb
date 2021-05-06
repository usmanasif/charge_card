class Card < ApplicationRecord
  has_many :transaction_lists

  enum status: { inactive: 0, active: 1 }
end
