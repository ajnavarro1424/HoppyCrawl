require 'rails_helper'

RSpec.feature "Breweries", type: :feature do
  context "I can create a new Brewery with all its variables" do
    Steps "See Above" do
      Given "We are on the Brewery index page" do
        visit '/breweries'
        expect(page).to have_content("Breweries")
      end
    end
  end
end

context "clicking on new brewery" do
  Steps "for creating a new brewey listing" do
    Given "that I am on the brewery landing page" do
      visit "/breweries/new"
    end
    Then "I can enter my information" do
      fill_in 'Name', with: 'Brewery_1'
      fill_in 'Address', with: '701 J street'
      fill_in 'Website', with: 'test.com'
      fill_in 'Description', with: 'test'
      click_button 'Create Brewery'
    end
    Then "I am taken to a page that shows the new brewery in the list"
    expect(page).to have_content 'Brewery_1'
  end
end
