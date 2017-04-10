require 'rails_helper'

RSpec.feature "CorrectOrderBrewStops", type: :feature do
  before(:each) do
    User.create!(email: "b@b.com", password: "Password", dob: "1987-05-12")
      breweries = Brewery.create([{name: 'Mike Hess Brewing North Park', address: '3812 Grime Ave, San Diego, CA 92104',  latitude: 32.7496221, longitude: -117.1359937 }, {name: 'North Park Beer Company', address: '3038 Univeristy Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'Belching Beaver North Park', address: '4223 30th St, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'ChuckAlek Biergarten', address: '3139 University Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'Eppig Brewing', address: '3052 El Cajon Blvd, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }])
    visit "/"
    click_link "Log In"
    fill_in "user[email]", with: "b@b.com"
    fill_in "user[password]", with: "Password"
    click_button "Log In"
    expect(page).to have_content("Signed in successfully.")
  end

  context "As a user, I can change the times of my brew stops, which will automatically update the order" do
    Steps "See above" do
      Given "I have generated a crawl" do
        fill_in 'address', with: 'North Park, San Diego' #Addresses actually matter now! 92111 is not in the 5 mile radius of our breweries
        click_button 'Crawl'
      end
      When "I change the times of a brew crawl" do
        select '04 PM', :from => 'crawl_brewery_stops_attributes_2_start_time_4i'
        click_button 'Update Crawl'
      end
      Then "The brew stops will be in order of start times" do
        expect(page).to have_select("crawl_brewery_stops_attributes_2_start_time_4i", selected: '04 PM')
      end
    end
  end
end
