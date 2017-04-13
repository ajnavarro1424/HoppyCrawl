require 'rails_helper'

RSpec.describe Crawl, type: :model do


  context "it has an address" do
    it "knows when its address is invalid" do
        c = Crawl.new
        c.address = "Believe it or not, this is an invalid address."
        expect(c.invalid_address).to be true
    end

    it "knows when its address is valid" do
      c = Crawl.new
      c.address = "1600 Pennsylvania Ave NW, Washington, DC 20500"
      expect(c.invalid_address).to be false
    end
  end

  context "it does not have an address" do

    it "will still return true" do
      c = Crawl.new
      expect(c.invalid_address).to be true
    end
  end

  context "there are 5 breweries" do
    before(:each) do
      breweries = Brewery.create([{name: 'Mike Hess Brewing North Park', address: '3812 Grime Ave, San Diego, CA 92104',  latitude: 32.7496221, longitude: -117.1359937 }, {name: 'North Park Beer Company', address: '3038 Univeristy Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM"  }, {name: 'Belching Beaver North Park', address: '4223 30th St, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'ChuckAlek Biergarten', address: '3139 University Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'Eppig Brewing', address: '3052 El Cajon Blvd, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM"  }])
      User.create!(email: "bob@bob.com", password: "bobpassword", dob: "1987-05-12" ) if User.find_by_email("bob@bob.com").nil?

    end

    it "has to be real" do
      expect{Crawl.new}.to_not raise_error
    end

    it "cannot generate brewery_stops if it does not have an address and/or lat/lng" do
      crawl = Crawl.new
      crawl.user_id = User.first.id
      crawl.save
      expect(crawl.brewery_stops.length).to eq(0)
    end

    it "can generated up to five brewery_stops if at least its address is valid" do
      crawl = Crawl.new
      crawl.user_id = User.first.id
      crawl.address = "North Park, San Diego"
      crawl.save
      expect(crawl.brewery_stops.length).to eq(5)
    end

    it "has to save the five brewery_stops it generates to the database" do
      crawl = Crawl.new
      crawl.user_id = User.first.id
      crawl.address = "North Park, San Diego"
      crawl.save
      expect(BreweryStop.all.size).to eq(5)
    end

    it "should not fail to save if there are not enough breweries in the database" do
      Brewery.destroy_all
      BreweryStop.destroy_all
      breweries = Brewery.create([{name: 'Mike Hess Brewing North Park', address: '3812 Grime Ave, San Diego, CA 92104',  latitude: 32.7496221, longitude: -117.1359937 }, {name: 'North Park Beer Company', address: '3038 Univeristy Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM"  }])
      # make a new crawl (unsaved)
      crawl = Crawl.new
      crawl.user_id = User.first.id
      crawl.address = "North Park, San Diego"
      crawl.save
      expect(BreweryStop.all.size).to eq(2)
    end
    it "should not fail to save if there are no breweries in the database" do
      Brewery.destroy_all
      BreweryStop.destroy_all
      # make a new crawl (unsaved)
      crawl = Crawl.new
      crawl.user_id = User.first.id
      # expect{crawl.add_brew_stops}.to_not raise_error
      crawl.address = "North Park, San Diego"
      expect(crawl.save).to eq true
    end
    it "should not fail to save if there are no breweries in the radius of the search" do
      Brewery.destroy_all
      BreweryStop.destroy_all
      # make a new crawl (unsaved)
      crawl = Crawl.new
      crawl.user_id = User.first.id
      # expect{crawl.add_brew_stops}.to_not raise_error
      crawl.address = "92111"
      expect(crawl.save).to eq true
      expect(crawl.brewery_stops.length).to eq(0)
    end
  end
end
