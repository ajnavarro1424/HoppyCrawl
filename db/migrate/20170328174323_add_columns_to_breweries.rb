class AddColumnsToBreweries < ActiveRecord::Migration[5.0]
  def change
      add_column :breweries, :phone_number, :string
      add_column :breweries, :hours, :string
      add_column :breweries, :rating, :string
  end
end
