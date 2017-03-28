require 'rails_helper'

RSpec.feature "Breweries", type: :feature do
  context "clicking on new brewery" do
    Steps "for creating a new brewey listing" do
      Given "that I am on the brewery landing page" do
        visit '/breweries'
        click_link 'New Brewery'
        expect(page).to have_content 'New Brewery'
      end
      When "I enter my information" do
        fill_in 'Name', with: 'Brewery_1'
        fill_in 'Address', with: '701 J street'
        fill_in 'Website', with: 'test.com'
        fill_in 'Hours', with: '7-7'
        fill_in 'Phone number', with: '868-010-9221'
        fill_in 'Description', with: 'test'
        fill_in 'Rating', with: '3.4'
        click_button 'Create Brewery'
      end
      Then "I am taken to a page that shows the new brewery added" do
        expect(page).to have_content 'Brewery was successfully created.'
        expect(page).to have_content '868-010-9221'
      end
    end
  end

  context "Editing a Brewery" do
    Steps "for editing the Brewery information" do
      Given "I click on edit link" do
        create_brewery
        visit "/breweries"
        expect(page).to have_content 'test.com'
        click_link "Edit"
      end
      When "I edit information on Edit page" do
        fill_in 'Name', with: 'Brewery_1'
        fill_in 'Address', with: '701 J street'
        fill_in 'Website', with: 'test.com'
        fill_in 'Hours', with: '7-7'
        fill_in 'Phone number', with: '868-010-9221'
        fill_in 'Description', with: 'test'
        fill_in 'Rating', with: '3'
        click_button "Update Brewery"
      end
      Then "I expect to see my edited Brewery" do
        expect(page).to have_content '7-7'
        expect(page).to have_content '3'
      end
    end
  end

  context "Destroying a Brewery" do
    Steps "for destroying the Brewery" do
      Given "I have a brewery on the Breweries page" do
        create_brewery
        visit "/breweries"
        expect(page).to have_content 'test.com'
      end
      When "I click on the destroy link" do
        click_link "Destroy"
      end
      Then "The Brewery will be destroyed" do
        expect(page).to have_content 'Brewery was successfully destroyed.'
        expect(page).to_not have_content 'test.com'
      end
    end
  end

  context "Showing Brewery info" do
    Steps "for showing Brewery info" do
      Given "I am on the Breweries page" do
        create_brewery
        visit "/breweries"
        expect(page).to have_content 'test.com'
      end
      When "I click on the show link" do
        click_link "Show"
      end
      Then "I am taken to the show page for that Brewery" do
        expect(page).to have_content 'Rating: 5'
      end
    end
  end
end #end of RSpec
