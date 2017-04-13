require 'rails_helper'

RSpec.feature "ShareableCrawls", type: :feature do
  context "A logged in user can make their crawls public for other users to see" do
    Steps "The user can make their crawls public" do
      Given "The user logs and they are on the crawls index page" do
        @user = create_user
        login_as(@user, :scope => :user)
        @crawl = Crawl.create!(name: "North Park", created_at: "2017-04-05 21:04:52", updated_at: "2017-04-05 23:51:58", user_id: @user.id, address: "North Park, San Diego", latitude: 32.7456484, longitude: -117.1294166, date: nil, shareable: false)
        visit '/crawls'
      end
      And "The user clicks on one of their crawls to make public" do
        click_link('Make Public', match: :first)
      end
      Then "The specific crawl is populated in the public crawls table" do
        click_link("Show")
      end
    end
  end
end#end of RSpec
