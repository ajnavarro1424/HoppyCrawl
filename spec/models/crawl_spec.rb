require 'rails_helper'

RSpec.describe Crawl, type: :model do
  context "there are 5 breweries" do
    before(:each) do
      breweries = Brewery.create([{name: 'Mike Hess Brewing North Park', address: '3812 Grime Ave, San Diego, CA 92104',  latitude: 32.7496221, longitude: -117.1359937 }, {name: 'North Park Beer Company', address: '3038 Univeristy Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'Belching Beaver North Park', address: '4223 30th St, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'ChuckAlek Biergarten', address: '3139 University Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'Eppig Brewing', address: '3052 El Cajon Blvd, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }])
      User.create!(email: "bob@bob.com", password: "bobpassword", dob: "1987-05-12" ) if User.find_by_email("bob@bob.com").nil?

    end

    it "has to be real" do
      expect{Crawl.new}.to_not raise_error
    end

    it "has to generate five brewery_stops" do
      crawl = Crawl.new
      crawl.user_id = User.first.id
      crawl.save
      expect(crawl.brewery_stops.length).to eq(5)
    end

    it "has to save the five brewery_stops it generates to the database" do
      crawl = Crawl.new
      crawl.user_id = User.first.id
      crawl.save
      expect(BreweryStop.all.size).to eq(5)
    end
  end

  context "there are less than 5 breweries" do

    it "should not fail to save if there are not enough breweries" do
      Brewery.destroy_all
      BreweryStop.destroy_all
      breweries = Brewery.create([{name: 'Mike Hess Brewing North Park', address: '3812 Grime Ave, San Diego, CA 92104',  latitude: 32.7496221, longitude: -117.1359937 }, {name: 'North Park Beer Company', address: '3038 Univeristy Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }])
      # make a new crawl (unsaved)
      crawl = Crawl.new
      crawl.user_id = User.first.id
      crawl.save
      expect(BreweryStop.all.size).to eq(2)
    end
    it "should not fail to save if there are no breweries" do
      Brewery.destroy_all
      BreweryStop.destroy_all
      # make a new crawl (unsaved)
      crawl = Crawl.new
      crawl.user_id = User.first.id
      # expect{crawl.add_brew_stops}.to_not raise_error
      crawl.save
      expect(BreweryStop.all.size).to eq(0)
    end
  end
end
