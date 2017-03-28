class AddUserToCrawls < ActiveRecord::Migration[5.0]
  def change
    add_reference :crawls, :user, foreign_key: true
  end
end
