require 'rails_helper'

RSpec.feature "Emailers", type: :feature do
  context "We can successfully send a reset password email" do
    Steps "See above" do
      Given "I have clicked the reset password button" do
        User.destroy_all
        @user = User.create!(email: "bob@bob.com", password: "bobpassword", dob: "1987-05-12" )
        visit '/users/password/new'
        fill_in 'user[email]', with: "bob@bob.com"
        click_button "Send reset email"

      end
      And "A reset password email was sent to the correct account" do
       open_email(@user.email)
       expect(current_email).to have_content("Hello #{@user.email}! Someone has requested a link to change your password.")
      end
      And "A notice is posted on our page" do
        expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
      end
    end
  end
end
