require 'rails_helper'

RSpec.feature "AdminSearchDestroys", type: :feature do
  context "An admin has the ability to search and modify/delete crawls" do
    Steps "An admin has the ability to modify crawls" do
      Given "An admin user is created and on the crawls index page" do
        @admin = create_admin
        @admin.add_role :admin

        Crawl.create!([{name: "North Park", created_at: "2017-04-05 21:04:52", updated_at: "2017-04-05 23:51:58", user_id: @admin.id, address: "North Park, San Diego", latitude: 32.7456484, longitude: -117.1294166, date: nil}, {name: "Downtown", created_at: "2017-04-05 21:04:52", updated_at: "2017-04-05 23:51:58", user_id:@admin.id, address: "92101", latitude: 32.7456484, longitude: -117.1294166, date: nil}])
        visit '/'
        click_link "Log In"
        fill_in "user[email]", with: "admin@test.com"
        fill_in "user[password]", with: "123456"
        click_button "Log In"
        click_link 'Crawls'
      end
      And "An admin searches for a specific crawl on the crawls page" do
        # Empty field search
        click_button "Search"
        expect(page).not_to have_content "Search Results"
        # Name or Address Search
        fill_in "Search by Name or Address:", with: "North Park"
        click_button "Search"
        expect(page).to have_content "Search Results"
        # User id search
        fill_in "Search by User ID:", with: @admin.id
        click_button "Search"
        expect(page).to have_content "Search Results"

      end
      Then "An admin deletes a specific crawl on the crawl page" do
        click_link("Delete", match: :first)
        # click_button "Yes"
        expect(page).to have_content "Crawl was successfully destroyed."

      end
    end
  end
end
