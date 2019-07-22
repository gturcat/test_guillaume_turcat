class AddDateStatusToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :date_status, :date
  end
end
