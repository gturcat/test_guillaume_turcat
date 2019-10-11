class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :to
      t.string :subject
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
