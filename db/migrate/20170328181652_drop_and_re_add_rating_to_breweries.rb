class DropAndReAddRatingToBreweries < ActiveRecord::Migration[5.0]
  def change
    remove_column :breweries, :rating
    add_column :breweries, :rating, :integer
  end
end
