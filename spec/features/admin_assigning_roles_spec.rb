require 'rails_helper'
require 'cancan/matchers'

RSpec.feature "AdminAssigningRoles", type: :feature do
  context "Admin can assign admin role to users" do
    Steps "for Assigning admin roles to users" do
      #below we must have a user in the test for the admin to assign roles to
      Given "A user is created" do
        #we call the method create_user which exists in the admin_features support file, save it in a variable @users:
        @user = create_user
      end
      #we create an admin:
      And "An Admin with email ghamedina@gmail.com  and password 123456" do
        user = User.create!(email: "ghamedina@gmail.com", password: "123456", dob: "1987-05-12" )
        user.add_role :admin
      end
      And "The user is on the landing page" do
        visit '/'
        click_link 'Log In'
      end
      And "I enter my information" do
        fill_in 'Email', with: 'ghamedina@gmail.com'
        fill_in 'Password', with: '123456'
        click_button 'Log In'
      end
      And "Admin is on landing_page" do
        visit '/'
      end
      And "Admin can see Admin Tools" do
        
        expect(page).to have_content "Admin Tools"
      end
      And "Admin can click on Admin Tools" do
        click_link "Admin Tools"
        expect(page).to have_content "User Roles"
      end
      And "Admin can remove admin role" do
        #the test admin now can click on the Make Admin button, that is specific to the id make_admin_ and refers back to @user:
        click_button 'Make Admin', id: "make_admin_#{@user.id}"
      end
      And "Admin can remove admin role" do
        click_button 'Remove Admin', id: "remove_admin_#{@user.id}"
      end
    end
  end
end#rspec
