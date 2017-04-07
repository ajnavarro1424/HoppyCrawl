class AddDateToCrawl < ActiveRecord::Migration[5.0]
  def change
    add_column :crawls, :date, :date
  end
end
