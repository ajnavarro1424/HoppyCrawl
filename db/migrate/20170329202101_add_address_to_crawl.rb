class AddAddressToCrawl < ActiveRecord::Migration[5.0]
  def change
    add_column :crawls, :address, :string
  end
end
