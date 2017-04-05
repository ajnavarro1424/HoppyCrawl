class CreateBreweryStops < ActiveRecord::Migration[5.0]
  def change
    create_table :brewery_stops do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :brewery, foreign_key: true
      t.references :crawl, foreign_key: true

      t.timestamps
    end
  end
end
