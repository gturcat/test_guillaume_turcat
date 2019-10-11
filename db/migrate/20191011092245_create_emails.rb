class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.text :body
      t.string :subject
      t.string :to
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
