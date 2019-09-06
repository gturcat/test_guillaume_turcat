class RenameColumnToDesk < ActiveRecord::Migration[5.2]
  def change
    rename_column :desks, :img, :photo
  end
end
