json.array!(@datapoints) do |datapoint|
  json.extract! datapoint, :goal_id, :amount, :date
  json.url datapoint_url(datapoint, format: :json)
end
