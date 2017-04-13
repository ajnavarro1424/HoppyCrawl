require 'rails_helper'
require 'cancan/matchers'

RSpec.feature "Breweries As Admin", type: :feature do
  context "Logging in as an admin" do
    Steps "for logging in as an admin" do
      Given "A user with email ghamedina@gmail.com  and password 123456" do
        # Drop all breweries from the db so only the one created in this test exsits
        Brewery.destroy_all
        user = User.create!(email: "ghamedina@gmail.com", password: "123456", dob: "1987-05-12" )
        user.add_role :admin
        # sign_in(user) can use this instead of line 14-30
      end
      Given "The user is on the landing page" do
        visit '/'
        click_link 'Log In'
      end
      When "I enter my information" do
      fill_in 'Email', with: 'ghamedina@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log In'
      end
      And "I am redirected to the landing page" do
        expect(page).to have_content '21'
        expect(page).to have_content 'or'
        #once our modal has been fixed, change 21 to Breweries, and or to Crawl
      end
      And "I click the yes button" do
        click_button 'YES'
      end
      And "I expect to see landing page" do
        visit '/'
        expect(page).to have_content 'HOP TO IT'
      end
      And "I click Breweries link" do
        expect(page).to have_content 'Breweries'
        click_link 'Breweries'
      end
      And "that I am on the brewery landing page" do
        visit '/breweries'
        click_link 'New Brewery'
        expect(page).to have_content 'New Brewery'
      end
      And "I enter my information" do
        fill_in 'Name', with: 'Brewery_1'
        fill_in 'Address', with: '701 J street'
        fill_in 'Website', with: 'test.com'
        fill_in 'Hours', with: '7-7'
        fill_in 'Phone number', with: '868-010-9221'
        fill_in 'Description', with: 'test'
        fill_in 'Rating', with: '3.4'
        fill_in 'Latitude', with: '54.55'
        fill_in 'Longitude', with: '34.66'
        click_button 'Create Brewery'
      end
      And "I am taken to a page that shows the new brewery added" do
        expect(page).to have_content 'Brewery was successfully created.'
        expect(page).to have_content '868-010-9221'
      end
      And "I click on edit link" do
        click_link "Edit"
      end
      And "I edit information on Edit page" do
        fill_in 'Name', with: 'Brewery_1'
        fill_in 'Address', with: '701 J street'
        fill_in 'Website', with: 'test.com'
        fill_in 'Hours', with: '7-7'
        fill_in 'Phone number', with: '868-010-9221'
        fill_in 'Description', with: 'test'
        fill_in 'Rating', with: '3'
        click_button "Create Brewery"
      end
      And "I expect to see my edited Brewery" do
        expect(page).to have_content '7-7'
        expect(page).to have_content '3'
        click_link 'Back'
      end
      And "I have a brewery on the Breweries page" do
        expect(page).to have_content 'test.com'
      end
      And "I click on the destroy link" do
        click_link "Destroy"
      end
      And "The Brewery will be destroyed" do
        expect(page).to have_content 'Brewery was successfully destroyed.'
      end
    end
  end

  context "Logging in as a non Admin user" do
    Steps "for logging in as a non Admin user" do
      Given "A user with email ghamedina@gmail.com  and password 123456" do
        user = User.create!(email: "ghamedina@gmail.com", password: "123456", dob: "1987-05-12" )
        login_as(user, :scope => :user)
      end
      And "I expect to see landing page" do
        visit '/'
        expect(page).to have_content 'HOP TO IT'
      end
      And "I cannot see Breweries link" do
        expect(page).to_not have_content 'Breweries'
      end
      And "I cannot access Breweries page at all" do
        visit '/breweries'
        expect(page).to have_content "You are not authorized to access this page."
      end
    end
  end
end #end of RSpec
