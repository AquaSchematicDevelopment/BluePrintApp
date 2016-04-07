json.array!(@seasons) do |season|
  json.extract! season, :id, :league_id, :name
  json.url season_url(season, format: :json)
end
