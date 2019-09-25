class Prestation < ApplicationRecord
  belongs_to :price, optional: true
  monetize :detail_price_cents
end
