json.array!(@holdings) do |holding|
  json.extract! holding, :id, :profolio_id, :team_id, :blue_prints
  json.url holding_url(holding, format: :json)
end
