require 'rails_helper'

RSpec.feature "CreateCrawlsV2s", type: :feature do
        before(:each) do
    User.create!(email: "bob@bob.com", password: "bobpassword", dob: "1987-05-12" ) if User.find_by_email("bob@bob.com").nil?
    visit '/'
    click_link 'Log In'
    fill_in 'Email', with: 'bob@bob.com'
    fill_in 'Password', with: 'bobpassword'
    click_button 'Log In'
    breweries = Brewery.create([{name: 'Mike Hess Brewing North Park', address: '3812 Grime Ave, San Diego, CA 92104',  latitude: 32.7496221, longitude: -117.1359937 }, {name: 'North Park Beer Company', address: '3038 Univeristy Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'Belching Beaver North Park', address: '4223 30th St, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649}, {name: 'ChuckAlek Biergarten', address: '3139 University Ave, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }, {name: 'Eppig Brewing', address: '3052 El Cajon Blvd, San Diego, CA 92104', latitude: 32.7494235, longitude: -117.1252649 }])
  end

  context "As a logged in user on the landing page, I can generate a crawl with 5 breweries" do
    Steps "See above" do
      Given "I am on the landing page and click Log In" do
        visit '/'
      end
      When "I enter my location" do
        fill_in 'address', with: 'North Park, San Diego'
        click_button 'Crawl'
      end
      Then "I am taken to a page that has 5 breweries" do
        expect(page).to have_content('Mike Hess Brewing North Park')
        expect(page).to have_content('North Park Beer Company')
        expect(page).to have_content('Belching Beaver North Park')
        expect(page).to have_content('ChuckAlek Biergarten')
        expect(page).to have_content('Eppig Brewing')
      end
    end
  end

  context "As a logged in user I can update my crawls times" do
    Steps "See above" do
      Given "I generate a crawl" do
        fill_in 'address', with: 'North Park, San Diego'
        click_button 'Crawl'
      end
      When "I change the start time of a brewery stop and save it" do
        select "04 PM", :from => "crawl_brewery_stops_attributes_2_start_time_4i" #year
        click_button 'Update Crawl'
      end
      Then "The start time has changed" do
        expect(page).to have_content("04 PM")
      end
      And "I change the end time of brewery stop and save it" do
        select "10 PM", :from => "crawl_brewery_stops_attributes_0_end_time_4i"
        click_button 'Update Crawl'
      end
      Then "The end time has changed" do
        expect(page).to have_content("10 PM")
      end
    end
  end
end
