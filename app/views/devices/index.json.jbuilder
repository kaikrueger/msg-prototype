json.array!(@devices) do |device|
  json.extract! device, :uuid, :name
  json.url device_url(device, format: :json)
end