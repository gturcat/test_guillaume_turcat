class AddAdressToDesk < ActiveRecord::Migration[5.2]
  def change
    add_column :desks, :address, :string
  end
end
