require 'rails_helper'

RSpec.feature "SaveAndAddNamesToCrawls", type: :feature do
  context "As a signed in user I can save my maps & add a crawl name" do
    Steps "On the crawl show page a logged in user can see and edit the name of that specific crawl" do
      Given "We are on the landing page and the user logs in" do
        @user = create_user
        login_as(@user, :scope => :user)
        visit '/'
        fill_in "address", with: "92111"
        click_button 'Crawl'
      end
      When "A logged in user goes to the crawl show page, they can edit the crawl name" do
        expect(page).to have_content("Name your crawl")
      end
      Then "I can change the crawl name and save my changes" do
        c1 = Crawl.last
        fill_in "crawl[name]", with: "Best Crawls Evah"
        puts page.body
        click_button 'Update Crawl'
        c2 = Crawl.last
        expect(c1).to eq(c2)
        expect(page).to have_content 'Crawl was successfully updated.'
        save_and_open_page
      end
      And "I am a signed in user on the crawls index page and can only see my crawls" do
        click_link 'Crawls'
        expect(page).to have_content ("Best Crawls Evah")
        expect(page).to_not have_content("Other Crawl")
      end
    end
  end
end#end of rspec
