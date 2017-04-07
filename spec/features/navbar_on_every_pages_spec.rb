require 'rails_helper'

RSpec.feature "NavbarOnEveryPages", type: :feature do
  context "As a user I can see the nav bar on the landing page" do
    Steps "Visit landing page without logging in" do
      visit "/"
      expect(page).to have_link('Log In')
      expect(page).to have_link('Sign Up')
    end
  end
  context "As a user I can see the nav bar on the login page" do
    Steps "Visit login page" do
      visit "/users/sign_in"
      expect(page).to have_link('Log In')
      expect(page).to have_link('Sign Up')
    end
  end
  context "As a user I can see the nav bar on the profile page" do
    Steps "Visit login page" do
      @user = create_user
      login_as(@user, :scope => :user)
      visit "/users/edit"
      expect(page).to have_link('Logout')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Crawls')
    end
  end
  context "As an admin user I can see the nav bar on the profile page" do
    Steps "Visit admin edit page" do
      @user = create_user
      @user.add_role :admin
      login_as(@user, :scope => :user)
      visit "/users/edit"
      expect(page).to have_link('Crawls')
      expect(page).to have_link('Breweries')
      expect(page).to have_link('Admin Tools')
    end
  end
end#rspec
