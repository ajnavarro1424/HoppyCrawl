module BreweryFeatures
  include Warden::Test::Helpers
  def create_brewery
    Brewery.create(name: "Erik", address: "Address", website: "test.com", description: "Description", phone_number: "858-555-1234", hours: "Monday: 12:00 – 10:00 PM Tuesday: 12:00 – 10:00 PM Wednesday: 12:00 – 10:00 PM Thursday: 12:00 – 10:00 PM Friday: 12:00 PM – 12:00 AM Saturday: 12:00 PM – 12:00 AM Sunday: 12:00 – 10:00 PM" , rating: "5")
  end




end#end of module
