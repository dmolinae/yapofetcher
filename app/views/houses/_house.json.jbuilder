json.extract! house, :id, :title, :price, :rooms, :url, :created_at, :updated_at
json.url house_url(house, format: :json)
