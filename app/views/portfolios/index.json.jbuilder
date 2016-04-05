json.array!(@portfolios) do |portfolio|
  json.extract! portfolio, :id, :user_id, :league_id, :funds
  json.url portfolio_url(portfolio, format: :json)
end
