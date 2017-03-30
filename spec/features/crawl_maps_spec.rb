require 'rails_helper'

RSpec.feature "CrawlMaps", type: :feature do
 context "You enter a zip code onto the landing page and see a map of that area" do
   Steps "See above" do
     Given "We are on the landing page" do
       visit '/'
       expect(page).to have_content("HOP TO IT!")
     end
     When "I enter a zip code and click on the 'Crawl' button" do
       fill_in "address", with: '92111'
       click_button "Crawl"
     end
     Then "I am taken to a show page that has a map of that zip code on it" do
       expect(page).to_not have_content("One day there will be a map here...")
     end
   end
 end #end of context

end #end of feature
