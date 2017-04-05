require 'rails_helper'

RSpec.feature "CrawlMaps", type: :feature do
 context "You enter a zip code onto the landing page and see a map of that area" do
   Steps "See above" do
     # This test is broken, need text on page that verifies map was generated
      Given "We are on the landing page and logged in" do
       #  The test database is seeded with breweries
       breweries = Brewery.create([{name: 'Mike Hess Brewing North Park', address: '3812 Grime Ave, San Diego, CA 92104',  latitude: 32.7477, longitude: -117.12854 }, {name: 'North Park Beer Company', address: '3038 Univeristy Ave, San Diego, CA 92104', latitude: 32.748855, longitude: -117.129141 }, {name: 'Belching Beaver North Park', address: '4223 30th St, San Diego, CA 92104', latitude: 32.754689, longitude: -117.130043 }, {name: 'ChuckAlek Biergarten', address: '3139 University Ave, San Diego, CA 92104', latitude: 32.748305, longitude: -117.12633 }, {name: 'Eppig Brewing', address: '3052 El Cajon Blvd, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }])
       @user = create_user
       login_as(@user, :scope => :user)
       visit '/'
       expect(page).to have_content("HOP TO IT!")
      end
      When "I enter a zip code and click on the 'Crawl' button" do
       fill_in "address", with: '92111'
       click_button "Crawl"
      end
      And "I am taken to a show page that has a map of that zip code on it" do
       expect(page).to have_content("Crawl was successfully created.")
      end
      Then "I can generate a new crawl" do
       fill_in "address", with: "asdfasdf"
       click_button 'New Crawl'

       expect(page).to have_content("Please enter a valid address!")
      end
    end
  end #end of context
end #end of feature
