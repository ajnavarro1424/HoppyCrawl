module BreweryFeatures
  def create_brewery
    Brewery.create(name: "Erik", address: "Address", website: "test.com", description: "Description", phone_number: "858-555-1234", hours: "8-9", rating: "5")
  end




end#end of module
