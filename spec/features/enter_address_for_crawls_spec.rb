require 'rails_helper'

RSpec.feature "EnterAddressForCrawls", type: :feature do
  context "As a logged in user I can enter an address to generate a map" do
    Steps "See above" do
      Given "A user with email bob@bob.com and password bobpassword" do
        User.create!(email: "bob@bob.com", password: "bobpassword", dob: "1987-05-12" )
      end
      Given "I am a logged in user" do
        visit '/'
        click_link 'Log In'
      end
      When "I enter in my login credentials" do
        fill_in 'Email', with: 'bob@bob.com'
        fill_in 'Password', with: 'bobpassword'
        click_button 'Log In'
      end
      Then "I am on the landing page and can enter a street address" do
        expect(page).to have_content("HOP TO IT!")
        fill_in "address", with: "704 J Street San Diego, CA 92101"
        click_button "Crawl"
      end
      Then "I can see a map of my address" do
        expect(page).to have_content("Crawl was successfully created.")
      end
    end
  end

  context "As a non-logged-in user, I will be prompted to log in before I create a crawl" do
    Steps "See Above" do
      Given "I am a user with email bob@bob.com and password bobpassword" do
        User.create!(email: "bob@bob.com", password: "bobpassword", dob: "1987-05-12" )
      end
      And "I'm on the landing page" do
        visit '/'
        expect(page).to have_content("HOP TO IT!")
      end
      When "I enter a street address and generate a crawl" do
        fill_in "address", with: "704 J Street San Diego, CA 92101"
        click_button "Crawl"
      end
      Then "I am taken to a log in screen" do
        expect(page).to have_content("Log in")
      end
      And "when I enter my information" do
        fill_in 'Email', with: 'bob@bob.com'
        fill_in 'Password', with: 'bobpassword'
        click_button 'Log In'
      end
      Then "I am signed in and taken back to the landing page" do
        expect(page).to have_content("Signed in successfully.")
        expect(page).to have_content("HOP TO IT!")
      end
      And "I can successfully generate a new crawl" do
        fill_in "address", with: "704 J Street San Diego, CA 92101"
        click_button "Crawl"
        expect(page).to have_content("Crawl was successfully created.")
      end
    end
  end

  context "As a non-signed-up user, I cannot create a crawl" do
    Steps "See Above" do
      When "I enter a street address and create a crawl on the landing page" do
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
