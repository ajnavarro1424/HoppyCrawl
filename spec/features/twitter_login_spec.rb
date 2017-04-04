require 'rails_helper'

RSpec.feature "twitter_login", type: :feature do
  context "Signing in with twitter" do
    Steps "When I sign in with twitter" do
      Given "I am on the landing page" do
        visit '/'
      end
      When 'I see a modal checking my age' do
        expect(page).to have_content('Are you 21 or over?')
      end
      And 'I click on the yes button' do
        click_button 'YES'
        expect(page).to have_content('HOP TO IT!')
      end
      And 'I click on the Log In link' do
        click_link 'Log In'
        expect(page).to have_content('Sign in with Twitter')
      end
    end
  end
end
