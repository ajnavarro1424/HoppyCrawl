namespace :import do
  desc "hello world"
  task :run => :environment do
    BreweryStop.destroy_all #avoids duplicates; comment out if you don't want it
    Brewery.destroy_all
    @client = GooglePlaces::Client.new("AIzaSyBJ54EUBnt0RwAEIaIseMJQV2Dvnhmu_pA")
    sd_breweries = @client.spots_by_query('Breweries in San Diego', :multipage => true) #gets 60 breweries in San Diego
    # la_breweries = @client.spots_by_query('Breweries in Los Angeles', :multipage => true)
    # sf_breweries = @client.spots_by_query('Breweries in San Francisco', :multipage => true)
    # mn_breweries = @client.spots_by_query('Breweries in Minneapolis', :multipage => true)
    # ml_breweries = @client.spots_by_query('Breweries in Milwaukee', :multipage => true)
    # gr_breweries = @client.spots_by_query('Breweries in Grand Rapids', :multipage => true)
    # ny_breweries = @client.spots_by_query('Breweries in New York City', :multipage => true)
    # ch_breweries = @client.spots_by_query('Breweries in Chicago', :multipage => true)
    # se_breweries = @client.spots_by_query('Breweries in Seattle', :multipage => true)
    # de_breweries = @client.spots_by_query('Breweries in Denver', :multipage => true)
    # po_breweries = @client.spots_by_query('Breweries in Portland', :multipage => true)

    sd_breweries.each do |sd_b|
      if(Brewery.find_by_address(sd_b.formatted_address).nil?) #if there is not already a brewery at sd_b's address
        brewery = Brewery.new
        brewery.name = sd_b.name
        brewery.address = sd_b.formatted_address
        brewery.latitude = sd_b.lat
        brewery.longitude = sd_b.lng
        spot = @client.spot(sd_b.place_id)
        brewery.website = spot.website
        brewery.phone_number = spot.formatted_phone_number
        # We may need to modify the hours column in the brewery table to json form text
        brewery.hours = spot.opening_hours["weekday_text"].try(:join, "\n")
        debugger
        brewery.rating = spot.rating
        brewery.save
      end
    end

    # puts Brewery.count
    # la_breweries.each do |la_b|
    #   if(Brewery.find_by_address(la_b.formatted_address).nil?)
    #     brewery = Brewery.new
    #     brewery.name = la_b.name
    #     brewery.address = la_b.formatted_address
    #     brewery.latitude = la_b.lat
    #     brewery.longitude = la_b.lng
    #     brewery.website = @client.spot(la_b.place_id).website
    #     brewery.phone_number = @client.spot(la_b.place_id).formatted_phone_number
    #
    #     brewery.save
    #   end
    # end
    # sf_breweries.each do |sf_b|
    #   if(Brewery.find_by_address(sf_b.formatted_address).nil?)
    #     brewery = Brewery.new
    #     brewery.name = sf_b.name
    #     brewery.address = sf_b.formatted_address
    #     brewery.latitude = sf_b.lat
    #     brewery.longitude = sf_b.lng
    #     brewery.website = @client.spot(sf_b.place_id).website
    #     brewery.phone_number = @client.spot(sf_b.place_id).formatted_phone_number
    #
    #     brewery.save
    #   end
    # end
    # mn_breweries.each do |mn_b|
    #   if(Brewery.find_by_address(mn_b.formatted_address).nil?) #if there is not already a brewery at mn_b's address
    #     brewery = Brewery.new
    #     brewery.name = mn_b.name
    #     brewery.address = mn_b.formatted_address
    #     brewery.latitude = mn_b.lat
    #     brewery.longitude = mn_b.lng
    #     brewery.website = @client.spot(mn_b.place_id).website
    #     brewery.save
    #   end
    # end
    # ml_breweries.each do |ml_b|
    #   if(Brewery.find_by_address(ml_b.formatted_address).nil?) #if there is not already a brewery at ml_b's address
    #     brewery = Brewery.new
    #     brewery.name = ml_b.name
    #     brewery.address = ml_b.formatted_address
    #     brewery.latitude = ml_b.lat
    #     brewery.longitude = ml_b.lng
    #     brewery.website = @client.spot(ml_b.place_id).website
    #     brewery.save
    #   end
    # end
    # gr_breweries.each do |gr_b|
    #   if(Brewery.find_by_address(gr_b.formatted_address).nil?) #if there is not already a brewery at gr_b's address
    #     brewery = Brewery.new
    #     brewery.name = gr_b.name
    #     brewery.address = gr_b.formatted_address
    #     brewery.latitude = gr_b.lat
    #     brewery.longitude = gr_b.lng
    #     brewery.website = @client.spot(gr_b.place_id).website
    #     brewery.save
    #   end
    # end
    # ny_breweries.each do |ny_b|
    #   if(Brewery.find_by_address(ny_b.formatted_address).nil?) #if there is not already a brewery at ny_b's address
    #     brewery = Brewery.new
    #     brewery.name = ny_b.name
    #     brewery.address = ny_b.formatted_address
    #     brewery.latitude = ny_b.lat
    #     brewery.longitude = ny_b.lng
    #     brewery.website = @client.spot(ny_b.place_id).website
    #     brewery.save
    #   end
    # end
    # ch_breweries.each do |ch_b|
    #   if(Brewery.find_by_address(ch_b.formatted_address).nil?) #if there is not already a brewery at ch_b's address
    #     brewery = Brewery.new
    #     brewery.name = ch_b.name
    #     brewery.address = ch_b.formatted_address
    #     brewery.latitude = ch_b.lat
    #     brewery.longitude = ch_b.lng
    #     brewery.website = @client.spot(ch_b.place_id).website
    #     brewery.save
    #   end
    # end
    # se_breweries.each do |se_b|
    #   if(Brewery.find_by_address(se_b.formatted_address).nil?) #if there is not already a brewery at se_b's address
    #     brewery = Brewery.new
    #     brewery.name = se_b.name
    #     brewery.address = se_b.formatted_address
    #     brewery.latitude = se_b.lat
    #     brewery.longitude = se_b.lng
    #     brewery.website = @client.spot(se_b.place_id).website
    #     brewery.save
    #   end
    # end
    # de_breweries.each do |de_b|
    #   if(Brewery.find_by_address(de_b.formatted_address).nil?) #if there is not already a brewery at de_b's address
    #     brewery = Brewery.new
    #     brewery.name = de_b.name
    #     brewery.address = de_b.formatted_address
    #     brewery.latitude = de_b.lat
    #     brewery.longitude = de_b.lng
    #     brewery.website = @client.spot(de_b.place_id).website
    #     brewery.save
    #   end
    # end
    # po_breweries.each do |po_b|
    #   if(Brewery.find_by_address(po_b.formatted_address).nil?) #if there is not already a brewery at po_b's address
    #     brewery = Brewery.new
    #     brewery.name = po_b.name
    #     brewery.address = po_b.formatted_address
    #     brewery.latitude = po_b.lat
    #     brewery.longitude = po_b.lng
    #     brewery.website = @client.spot(po_b.place_id).website
    #     brewery.save
    #   end
    # end
  end
end
