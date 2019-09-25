class CreatePrestations < ActiveRecord::Migration[5.2]
  def change
    create_table :prestations do |t|
      t.string :name
      t.references :price, foreign_key: true
      t.timestamps
    end
  end
end
