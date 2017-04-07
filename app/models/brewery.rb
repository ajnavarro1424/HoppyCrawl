class Brewery < ApplicationRecord
  geocoded_by :address #Using this without a after_validate gives the model the Geocoder methods
  has_many :brewery_stops
	has_many :crawls, through: :brewery_stops
  validates :latitude, :longitude, presence: true
end
