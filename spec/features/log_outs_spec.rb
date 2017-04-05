require 'rails_helper'

 RSpec.feature "LogOuts", type: :feature do
  context "Logging out of site" do
     Steps "For logged in user who wants to logout" do
       Given "A user with email bob@bob.com and password bobpassword" do
         User.destroy_all
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
       Then "The user is redirected to the landing page" do
         expect(page).to have_content('Logout')
       end
       And "The user logs out" do
         click_link 'Logout'
         expect(page).to have_content('Signed out successfully.')
       end
     end
   end
 end
