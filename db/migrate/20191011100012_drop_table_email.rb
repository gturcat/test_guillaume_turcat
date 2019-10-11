class DropTableEmail < ActiveRecord::Migration[5.2]
  def change
    drop_table :emails
  end
end
