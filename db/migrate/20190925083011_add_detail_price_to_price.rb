class AddDetailPriceToPrice < ActiveRecord::Migration[5.2]
  def change
    add_monetize :prices, :detail_price, currency: { present: false }
  end
end
