require 'rails_helper'

RSpec.feature "UserCrawlGens", type: :feature do
  context "As a user, I can generate a crawl" do
    Steps "See Above" do
      Given "I have signed in" do
        User.create!(email: "b@b.com", password: "Password", dob: "1987-05-12")
        visit "/"
        click_link "Log In"
        fill_in "user[email]", with: "b@b.com"
        fill_in "user[password]", with: "Password"
        click_button "Log In"
        expect(page).to have_content("Signed in successfully.")
      end
      When "I enter a zip code and create a crawl" do
        fill_in "address", with: "92111"
        click_button "Crawl"
      end
      Then "I am taken to the Show Crawl page" do
        expect(page).to have_content("Crawl was successfully created.")
      end
    end
  end

  context "As a non-user, I CANNOT generate a crawl" do
    Steps "See Above" do
      When "I enter a zip code and create a crawl on the landing page" do
        visit "/"
        fill_in "address", with: "92111"
        click_button "Crawl"
      end
      Then "I am taken to the Log In page" do
        expect(page).to_not have_content("Crawl was successfully created.")
        expect(page).to have_content("Log in")
      end
    end
  end
end
