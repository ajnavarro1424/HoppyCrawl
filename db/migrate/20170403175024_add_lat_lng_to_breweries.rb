class AddLatLngToBreweries < ActiveRecord::Migration[5.0]
  def change
    add_column :breweries, :latitude, :float
    add_column :breweries, :longitude, :float
  end
end
