require 'rails_helper'

RSpec.feature "LocalLocations", type: :feature do
  before(:all) do
    Capybara.current_driver = :selenium
  end

  after(:all) do
    Capybara.use_default_driver
  end


  context "I can generate a crawl based on my current location", :js => true do
    Steps "See above" do
      Given "We are signed in" do
        User.create!(email: "b@b.com", password: "Password", dob: "1987-05-12")
        visit "/"
        click_link "Log In"
        fill_in "user[email]", with: "b@b.com"
        fill_in "user[password]", with: "Password"
        click_button "Log In"
        expect(page).to have_content("Signed in successfully.")
      end
      And "It has gotten my location" do
        page.find("#loc_ready").should have_content("Your position has been found!")
      end
    end
  end
end
