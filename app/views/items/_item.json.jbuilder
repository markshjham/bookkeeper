json.extract! item, :id, :description, :amount, :debit, :category, :subcategory, :transaction_date, :created_at, :updated_at
json.url item_url(item, format: :json)
