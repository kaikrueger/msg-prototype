json.array!(@sensors) do |sensor|
  json.extract! sensor, :uuid, :name
  json.url sensor_url(sensor, format: :json)
end