class AddColorToDesks < ActiveRecord::Migration[5.2]
  def change
    add_column :desks, :color, :string
  end
end
