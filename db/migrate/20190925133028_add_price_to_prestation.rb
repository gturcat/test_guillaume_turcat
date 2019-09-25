class AddPriceToPrestation < ActiveRecord::Migration[5.2]
  def change
    add_monetize :prestations, :detail_price, currency: { present: false }
  end
end
