class Price < ApplicationRecord
  belongs_to :desk
  monetize :detail_price_cents
  has_many :prestations
  accepts_nested_attributes_for :prestations
end
