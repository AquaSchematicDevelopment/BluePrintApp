json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :price, :amount
  json.url transaction_url(transaction, format: :json)
end
