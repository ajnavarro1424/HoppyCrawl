class Crawl < ApplicationRecord
	geocoded_by :address
	before_validation :geocode
	before_update :update_brew_stops
	belongs_to :user

	# added for many-to-many relationship, if crawl is deleted
	# associated brewery stops are deleted as well.
	has_many :brewery_stops, :dependent => :delete_all

	has_many :breweries, through: :brewery_stops
	# end of many-to-many relationship code
	resourcify

	validates :user, presence: true
	# after_create validates :name, presence: true

	after_create :add_brew_stops

	accepts_nested_attributes_for :brewery_stops

  def invalid_address
		Geocoder.search(address).empty?
	end

	private
		def add_brew_stops
			breweries = Brewery.near([latitude, longitude], 2).first(6)

			breweries.each do |b|
				bs = BreweryStop.new
				bs.brewery_id = b.id
				bs.crawl_id = id
				brewery_stops << bs
			end
		end


		def update_brew_stops
			brewery_stops.clear #Must be .clear, or it won't work!
			breweries = Brewery.near([latitude, longitude], 2).first(6)
			puts "Our Lat/Lngs are #{latitude}, #{longitude}"
			breweries.each do |b|
				puts "Name of brewery: #{b.name}"
				bs = BreweryStop.new
				bs.brewery_id = b.id
				bs.crawl_id = id
				brewery_stops << bs
			end
			puts Brewery.find(brewery_stops.first.brewery_id).name
		end

end
