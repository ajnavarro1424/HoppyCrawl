class AddLatLngToCrawl < ActiveRecord::Migration[5.0]
  def change
    add_column :crawls, :latitude, :float
    add_column :crawls, :longitude, :float
  end
end
