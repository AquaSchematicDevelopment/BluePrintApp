json.array!(@buy_requests) do |buy_request|
  json.extract! buy_request, :id, :amount, :price
  json.url buy_request_url(buy_request, format: :json)
end
