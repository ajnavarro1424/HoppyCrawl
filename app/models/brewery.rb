class Brewery < ApplicationRecord
  has_many :brewery_stops
	has_many :crawls, through: :brewery_stops
  validates :latitude, :longitude, presence: true
end
