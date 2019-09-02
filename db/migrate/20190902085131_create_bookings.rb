class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user
      t.references :desk

      t.timestamps
    end
  end
end
