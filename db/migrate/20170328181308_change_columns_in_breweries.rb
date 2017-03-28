class ChangeColumnsInBreweries < ActiveRecord::Migration[5.0]
  def change
    change_column :breweries, :address, :text
    change_column :breweries, :hours, :text
    change_column :breweries, :description, :text
  end
end
