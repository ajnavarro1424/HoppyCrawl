class AddStartAndEndTimesBackToBreweryStops < ActiveRecord::Migration[5.0]
  def change
    add_column :brewery_stops, :start_time, :time
    add_column :brewery_stops, :end_time, :time
  end
end
