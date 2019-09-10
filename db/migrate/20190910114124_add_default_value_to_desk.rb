class AddDefaultValueToDesk < ActiveRecord::Migration[5.2]
   def up
    change_column :desks, :freedays, :integer, default: Date.current.end_of_month.day
  end

  def down
    change_column :desks, :freedays, :integer, default: nil
  end
end
