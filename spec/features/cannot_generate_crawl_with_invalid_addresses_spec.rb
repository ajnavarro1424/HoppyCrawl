require 'rails_helper'

RSpec.feature "CannotGenerateCrawlWithInvalidAddresses", type: :feature do
  before(:each) do
    User.create!(email: "bob@bob.com", password: "bobpassword", dob: "1987-05-12" ) if User.find_by_email("bob@bob.com").nil?
    visit '/'
    click_link 'Log In'
    fill_in 'Email', with: 'bob@bob.com'
    fill_in 'Password', with: 'bobpassword'
    click_button 'Log In'
  end

  context "As a user, I cannot generate a crawl if I enter an invalid address" do
    Steps "See above" do
      Given "I am on the landing page" do
        expect(page).to have_content("HOP TO IT!")
      end
      When "I click the Crawl button without entering an address" do
        click_button "Crawl"
      end
      Then "I am returned to the landing page with an error message" do
        expect(page).to have_content("Please enter a valid address!")
        expect(page).to have_content("HOP TO IT!")
      end
      And "A new Crawl is NOT put in the database" do
        expect(Crawl.all.empty?).to be true
      end
    end
  end


end
