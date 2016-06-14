json.array!(@characteristics) do |characteristic|
  json.extract! characteristic, :id, :name
  json.url characteristic_url(characteristic, format: :json)
end
