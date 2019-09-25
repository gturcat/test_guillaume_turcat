class ModifyReferenceToPrice < ActiveRecord::Migration[5.2]
  def change
    remove_reference :prices, :desks, index: true
    add_reference :prices, :desk, index: true
  end
end
