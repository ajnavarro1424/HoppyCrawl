require 'rails_helper'

RSpec.feature "SaveAndAddNamesToCrawls", type: :feature do
  context "As a signed in user I can save my maps & add a crawl name" do
    Steps "On the crawl show page a logged in user can see and edit the name of that specific crawl" do
      Given "We are on the landing page and the user logs in" do
        @user = create_user
        @otheruser = create_user_2
        @mycrawl = Crawl.create!(user_id: @user.id, name: 'My Crawl', address: '92111', latitude: '32.1', longitude: '-117.1' )
        @othercrawl = Crawl.create!(user_id: @otheruser.id, name: 'Other Crawl', address: '92111', latitude: '32.4', longitude: '-117.2')
        login_as(@user, :scope => :user)
        visit '/'
        fill_in "address", with: "92111"
        click_button 'Crawl'
      end
      When "A logged in user goes to the crawl show page, they can edit the crawl name" do
        expect(page).to have_content("Name your crawl")
      end
      Then "I can change the crawl name and save my changes" do
        fill_in "crawl[name]", with: "Best Crawls Evah"
        click_button 'Update Crawl'
        expect(page).to have_content 'Crawl was successfully updated.'
      end
      And "I am a signed in user on the crawls index page and can only see my crawls" do
        click_link 'Crawls'
        expect(page).to have_content ("Best Crawls Evah")
        expect(page).to_not have_content("Other Crawl")
      end
    end
  end
end#end of rspec
