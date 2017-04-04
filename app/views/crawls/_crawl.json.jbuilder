json.extract! crawl, :id, :name, :created_at, :updated_at, :address, :latitude, :longitude
json.url crawl_url(crawl, format: :json)
