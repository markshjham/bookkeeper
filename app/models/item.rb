class Item < ApplicationRecord
  validates :transaction_date, :description, :amount, :category, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 0}
end
