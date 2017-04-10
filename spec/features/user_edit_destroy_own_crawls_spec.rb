require 'rails_helper'

RSpec.feature "UserEditDestroyOwnCrawls", type: :feature do
  context "As a logged in user I can edit, show and destroy my crawls" do
    Steps "As a logged in user I can edit, show and destroy my crawls" do
      Given "I am a logged in user on the crawls index page" do
        @user = create_user
        @crawl = Crawl.create!(user_id: @user.id, name: 'My Crawl', address: '92111', latitude: '32.1', longitude: '-117.1' )
        login_as(@user, :scope => :user)
        visit '/crawls'
      end
      Then "I click on the edit link to modify my crawl" do
        click_link 'Edit'
        expect(page).to have_content('Make A New Crawl')
        fill_in "crawl[name]", with: "My cool crawl"
        click_button 'Update Crawl'
        @crawl.reload
        expect(page).to have_content('Crawl was successfully updated.')
        expect(@crawl.name).to eq 'My cool crawl'
      end
      Then 'I click on the destroy link to destroy my crawl' do
        click_link 'Back'
        expect { click_link 'Delete' }.to change(Crawl, :count).by(-1)
        expect(page).to_not have_content('My cool crawl')
        expect(page).to have_content('Crawl was successfully destroyed.')
      end
    end
  end
end
