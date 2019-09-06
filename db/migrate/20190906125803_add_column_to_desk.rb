class AddColumnToDesk < ActiveRecord::Migration[5.2]
  def change
    add_column :desks, :img, :string
  end
end
