require 'rails_helper'

RSpec.feature "Modals", type: :feature do
  context "Visiting HoppyCrawl Site" do
    Steps "When I visit the landing page" do
      Given "I am on the landing page" do
        visit '/'
      end
      When 'I see a modal checking my age' do
        expect(page).to have_content('Are you 21 or over?')
      end
      Then 'I click on the yes button' do
        click_button 'YES'
        expect(page).to have_content('HOP TO IT!')
      end
    end
  end
end
