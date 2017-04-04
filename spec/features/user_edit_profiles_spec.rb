require 'rails_helper'

RSpec.feature "UserEditProfiles", type: :feature do
  context "User can edit profile" do
    Steps "User edits profile" do
      Given "User is logged in and on the Crawl landing page" do
        @user = create_user
        login_as(@user, :scope => :user)
        visit '/'
        # save_and_open_page
      end
      And "User can click_link Profile" do
        click_link 'Profile'
      end
      And "User is on Edit user page can change their name, dob, email, and password" do
        # Check user values to match initialization values
        expect(@user.name).to eq 'Test Testerson'
        expect(@user.email).to eq 'test@test.com'
        expect(@user.dob.to_s).to eq "1985-05-05"
        fill_in 'Name', with: 'Test Changerson Spicy'
        select "1989", :from => "user_dob_1i" #year
        select "February", :from => "user_dob_2i" #month
        select "26", :from => "user_dob_3i" #day
        fill_in 'Email', with: 'change@change.com'
        fill_in 'Password', with: 'changepassword'
        fill_in 'Password confirmation', with:'changepassword'
        fill_in 'Current password', with: '123456'
        click_button 'Update'
      end
      And 'Use goes back to landing page and sees content Your account has been updated successfully.' do
        expect(page).to have_content 'Your account has been updated successfully.'
      end
      Then 'User editted info will be saved to database' do
        # Check user fields have changed after object reload
        @user.reload
        expect(@user.name).to eq 'Test Changerson Spicy'
        expect(@user.email).to eq 'change@change.com'
        expect(@user.dob.to_s).to eq '1989-02-26'
      end
    end
  end
end#ends rspec
