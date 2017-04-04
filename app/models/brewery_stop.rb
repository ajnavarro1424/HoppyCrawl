class BreweryStop < ApplicationRecord
  belongs_to :brewery
  belongs_to :crawl
end
