require 'rails_helper'

RSpec.feature "AccountCreations", type: :feature do
  context "Visiting HoppyCrawl" do
    Steps "Making an Account" do
      Given "The user is on the landing page" do
        click_link 'Sign Up'
      end
      When 'The user fills out the Sign Up form' do
        fill_in 'Name', with: 'Bob'
        fill_in 'Dob', with: '2017 March 28'
        fill_in 'Email', with: 'bob@bob.com'
        fill_in 'Password', with: 'bobpassword'
        fill_in 'Password confirmation', with:'bobpassword'
        click_button 'Sign up'
      end
      Then 'The user is redirected to the Crawl.index' do
        expect(page).to have_content('Welcome! You have signed up successfully.')
      end
    end
  end
end
