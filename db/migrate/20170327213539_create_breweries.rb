class CreateBreweries < ActiveRecord::Migration[5.0]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :address
      t.string :website
      t.string :description

      t.timestamps
    end
  end
end
