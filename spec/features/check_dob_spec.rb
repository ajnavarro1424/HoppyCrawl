require 'rails_helper'

RSpec.feature "check_dob", type: :feature do
  context "Checking date of birth is over 21 when logged in with Twitter" do
    before(:each) do
      Given "a user with a blank date of birth" do
        @user = User.create!(email: "bobby@bob.com", password: "bobpassword", provide: "twitter")
        login_as(@user, :scope => :user)
      end
    end
    Steps "User is asked to set DOB when look at the home page" do
      When "I load the home page" do
        visit '/'
      end
      Then "I see the user profile edit and I'm asked to fill in my date of birth" do
        # expect page to be /users/edit
        expect(page.current_url).to match("/users/edit")
        # exepect flash message to say "please fill in date of birth"
        expect(page).to have_content("Please fill in valid date of birth.")
      end
    end
    Steps "user is asked to set DOB when looking at a crawl page" do
      When "I load the crawl show page from the url" do
        visit '/crawls/1'
      end
      Then "I see the user profile edit and I'm asked to fill in my date of birth" do
        # expect page to be /users/edit
        expect(page.current_url).to match("/users/edit")
        # exepect flash message to say "please fill in date of birth"
        expect(page).to have_content("Please fill in valid date of birth.")
      end
    end
  end
end
