class Price < ApplicationRecord
  belongs_to :desk
  monetize :detail_price_cents
end
