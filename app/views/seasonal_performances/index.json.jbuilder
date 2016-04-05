json.array!(@seasonal_performances) do |seasonal_performance|
  json.extract! seasonal_performance, :id, :book_value, :team_id, :season_id
  json.url seasonal_performance_url(seasonal_performance, format: :json)
end
