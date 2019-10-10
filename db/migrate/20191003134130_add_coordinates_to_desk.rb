class AddCoordinatesToDesk < ActiveRecord::Migration[5.2]
  def change
    add_column :desks, :latitude, :float
    add_column :desks, :longitude, :float
  end
end
