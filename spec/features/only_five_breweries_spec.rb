require 'rails_helper'

RSpec.feature "OnlyFiveBreweries", type: :feature do
  context "Breweries can now perform Geocoder methods" do
    Steps "See above" do
      expect{Brewery.new.geocoded?}.to_not raise_error
    end
  end

  context "A crawl will now have five breweries based on your current location" do
    Steps "See Above" do
      Given "I am a logged-in user" do
        User.create!(email: "b@b.com", password: "Password", dob: "1987-05-12")
        breweries = Brewery.create([{name: 'Mike Hess Brewing North Park', address: '3812 Grime Ave, San Diego, CA 92104',  latitude: 32.7496221, longitude: -117.1359937, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM" }, {name: 'North Park Beer Company', address: '3038 Univeristy Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM" }, {name: 'Belching Beaver North Park', address: '4223 30th St, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM"  }, {name: 'ChuckAlek Biergarten', address: '3139 University Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM" }, {name: 'Eppig Brewing', address: '3052 El Cajon Blvd, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM" }, {name: 'Barrel Head Brewhouse', address: '1785 Fulton St, San Francisco, CA 94117, United States', latitude: 37.7757115, longitude: -122.4460537, hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM" }])
        visit "/"
        click_link "Log In"
        fill_in "user[email]", with: "b@b.com"
        fill_in "user[password]", with: "Password"
        click_button "Log In"
        expect(page).to have_content("Signed in successfully.")
      end
      When "I enter a valid address and generate a crawl" do
        fill_in 'address', with: 'North Park, San Diego'
        click_button 'Crawl'
      end
      Then "I am taken to a page that contains the five closest breweries to my location" do
        expect(page).to have_content("Mike Hess Brewing North Park")
        expect(page).to have_content("North Park Beer Company")
        expect(page).to have_content("Belching Beaver North Park")
        expect(page).to have_content("ChuckAlek Biergarten")
        expect(page).to have_content("Eppig Brewing")
        expect(page).to_not have_content("Barrel Head Brewhouse")
      end
    end
  end
end
