require 'rails_helper'

RSpec.feature "SetFiveBreweries", type: :feature do
  before(:all) do
    User.create!(email: "bob@bob.com", password: "bobpassword", dob: "1987-05-12" ) if User.find_by_email("bob@bob.com").nil?
    visit '/'
    click_link 'Log In'
    fill_in 'Email', with: 'bob@bob.com'
    fill_in 'Password', with: 'bobpassword'
    click_button 'Log In'
  end

  context "I can see a set of 5 breweries on a map I have generated" do
    Steps "See Above" do
      Given "I am on the landing page" do
        expect(page).to have_content("HOP TO IT!")
      end
      When "I generate a crawl" do
        fill_in "address", with: "704 J Street"
        click_button "Crawl"
      end
      Then "I am taken to a page that has map with 5 markers on it" do
        # wait_for_ajax
        expect(find('#crawl_map')['data-markers'].split('},{').count).to eq(5)
      end
    end
  end
end
