json.extract! brewery, :id, :name, :address, :website, :description, :created_at, :updated_at, :latitude, :longitude
json.url brewery_url(brewery, format: :json)
