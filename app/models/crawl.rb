class Crawl < ApplicationRecord
	geocoded_by :address
	after_validation :geocode
	belongs_to :user
	resourcify
	validates :user, presence: true
end
