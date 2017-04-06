class DropStartAndEndTimesFromBreweryStops < ActiveRecord::Migration[5.0]
  def change
    remove_column :brewery_stops, :start_time
    remove_column :brewery_stops, :end_time
  end
end
