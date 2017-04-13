class AddShareableToCrawls < ActiveRecord::Migration[5.0]
  def change
    add_column :crawls, :shareable, :boolean
  end
end
