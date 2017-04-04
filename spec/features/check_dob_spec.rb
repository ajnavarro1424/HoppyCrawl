require 'rails_helper'

RSpec.feature "check_dob", type: :feature do
 context "Checking date of birth is over 21 when logged in with Twitter" do
   Steps "for logged in user with Twitter to enter the site" do
     Given "a user with a blank date of birth" do
       When "I load the User edit page" do
        visit '/users/edit'
        end
       And "I'm asked to fill in my date of birth" do
        fill_in 'name', with: "Gerardo Cabral"
        select "1989", :from => "user_dob_1i" #year
        select "February", :from => "user_dob_2i" #month
        select "26", :from => "user_dob_3i" #day
        click_button "Update"
        end
        Then "I am redirected back to the landing page" do
          expect(page).to have_content("Your account has been")
        end
      end
    end
  end
end
