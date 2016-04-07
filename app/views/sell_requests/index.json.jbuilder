json.array!(@sell_requests) do |sell_request|
  json.extract! sell_request, :id, :price, :amount
  json.url sell_request_url(sell_request, format: :json)
end
