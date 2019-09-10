class AddFreeDaysToDesk < ActiveRecord::Migration[5.2]
  def change
    add_column :desks, :freedays, :integer
  end
end
